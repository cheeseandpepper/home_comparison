class FeatureTypesController < ApplicationController

  def index
    @feature_types = FeatureType.all
  end

  def show
    @feature_type = FeatureType.find(params[:feature_type][:id])
  end

  def new
    @feature_type = FeatureType.new
  end

  def edit
     @feature_type = FeatureType.new(feature_type_params)
  end

  def create
    @feature_type = FeatureType.new(feature_type_params)
    if @feature_type.save!
      redirect_to settings_path
    else
      render :new
    end
  end

  def update
    @feature_type = FeatureType.find(feature_type_params[:id])
  end

  def destroy
    @feature_type = FeatureType.find(params[:id])
    if @feature_type.destroy!
      redirect_to settings_path
    else
      redirect_to settings_path
    end
  end


  private

  def feature_type_params
      params.require(:feature_type).permit(:name, :weight)
    end
end