class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: [:show, :edit, :update, :destroy, :unhide]

  USER_AGENT = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

  # GET /houses
  # GET /houses.json
  def index
    if params["search"]
      if params["show_all"] == "true"
        @houses = current_user.houses.full_text_search(params["search"])
      else
        @houses = current_user.houses.active.full_text_search(params["search"])
      end
    else
      if params["show_all"] == "true"
        @houses = current_user.houses
      else
        @houses = current_user.houses.active
      end
    end
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
    @features    = @house.features
    @new_comment = @house.comments.build
    @comments    = @house.comments.where.not(id: nil)
  end

  # GET /houses/new
  def new
    @house = House.new
  end

  # GET /houses/1/edit
  def edit
  end

  # POST /houses
  # POST /houses.json
  def create
    structured_address = house_params[:address].split(', ')
    address            = structured_address[0]
    citystatezip       = "#{structured_address[1]}, #{structured_address[2]}"

    data = Rubillow::PropertyDetails.deep_search_results(
      { address: address, citystatezip: citystatezip }
    )

    if data.code == 508
      @house = House.new
      render :new, notice: "House could not be created! #{data.message}"
    else
      @house = Factories::HouseFactory.new(data).house
      page = HTTParty.get(@house.link, headers: {"User-Agent" => USER_AGENT})
      @house.page = page
      @house.user_id = current_user.id
      
      @house.image_url = Nokogiri::XML(page).css('.hip-photo')[0]&.attr('src')
      
      if data.code != 0
        Rails.console.warn("Code: #{data.code}")
        render json: { errors: [{code: data.code, message: data.message}]}  
      else
        respond_to do |format|
          if @house.save
            format.html { redirect_to house_path(@house.id), notice: 'House was successfully created.' }
            format.json { render :show, status: :created, location: @house }
          else
            binding.pry
            format.html { render :new, notice: "House could not be created! #{e.message}" }
            format.json { render json: @house.errors, status: :unprocessable_entity }
          end
        end
      end  
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    respond_to do |format|
      if @house.update(house_params)
        format.html { redirect_to @house, notice: 'House was successfully updated.' }
        format.json { render :show, status: :ok, location: @house }
      else
        format.html { render :edit }
        format.json { render json: @house.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.deactivate!
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully hidden.' }
      format.json { head :no_content }
    end
  end

  def unhide
    @house.activate!
    respond_to do |format|
      format.html { redirect_to houses_url, notice: 'House was successfully unhidden.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
      session[:house_score] = @house.score
      session[:house_max_score] = @house.max_score
      session[:house_overall_score] = @house.overall_score
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def house_params
      params.require(:house).permit(:name, :address, :price, :link, :image_url, :city_state_zip)
    end
end
