class House < ApplicationRecord
  searchkick(
    word_middle: [:name, :address, :city, :neighborhood, :description]
  )

  def search_data
    {
      name:         name,
      address:      address,
      city:         city,
      neighborhood: neighborhood,
      description:  description
    }
  end
  #include PgSearch
  #pg_search_scope :full_text_search, against: [:price, :address, :neighborhood, :city, :state, :zip, :description]

  has_many :features
  has_many :house_images
  has_many :comments
  has_many :tags, through: :house_tags
  belongs_to :user

  before_save :set_neighborhood, :set_description, :set_tags
  after_touch :calculate_score, if: Proc.new { |h| h.has_score? }
  after_create :update_price
  after_create :build_feature_factory
  #after_create :fetch_extra_details  

  validates :address, uniqueness: true

  scope :active,   -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  default_scope { order(score: :desc) }
  
  USER_AGENT = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36"

  def has_score?
    score.present?
  end

  def full_address
    "#{address}, #{city}, #{state} #{zip}"
  end

  def set_neighborhood
    self.neighborhood = NEIGHBORHOODS_BY_ZIP[zip.to_i]
  end

  def set_description
    self.description = get_description
  end

  def set_tags
    returh nil unless self.description
    TagParser.new(self.description).create!
  end

  # def refresh_house
  #   new_data = Rubillow::PropertyDetails.deep_search_results(
  #     { address: address, citystatezip: city_state_zip }
  #   )

  #   if new_data.code == 508
  #     return false
  #   else
  #     attributes = Factories::HouseFactory.new(new_data).build_params
  #     assign_attributes(attributes)
  #     self.page = HTTParty.get(self.link, headers: {"User-Agent" => USER_AGENT})
      
  #     self.image_url = Nokogiri::XML(page).css('.hip-photo')[0]&.attr('src')
  #   end
  # end

  def xml
    Nokogiri::XML.parse(page)
  end

  def build_feature_factory
    Factories::FeatureFactory.new(self.id)
  end

  def get_description
    xml&.css(".zsg-content-section")&.css('.hdp-header-description')&.css('.zsg-content-item')&.first&.text
  end

  def update_price
    self.price = xml.css('.estimates .home-summary-row')[1].text.strip.gsub(/\$|,/, '').to_i
    self.save!
  end

  def get_city
    self.city = xml.css('.addr_city').first.text.split(',').first
    self.save!
  end

  def get_state
    self.state = xml.css('.addr_city').first.text.split(',').last.split(' ').first
  end

  def get_zip
    self.state = xml.css('.addr_city').first.text.split(',').last.split(' ').last
  end


  def fetch_extra_details
    data = Rubillow::PropertyDetails.updated_property_details(zpid: house_ref)
  end

  def overall_score
    score&.round(2)
  end

  def per_dollar_score
    overall_score / (price.to_f / 1_000_000.to_f).round(2)
  end

  def updated_property_details
    Rubillow::PropertyDetails.updated_property_details({ zpid: house_ref })
  end

  def deep_comps(count)
    Rubillow::PropertyDetails.deep_comps({ zpid: house_ref, count: count })
  end

  def self.deep_search_results(address, citystatezip)
    Rubillow::PropertyDetails.deep_search_results(
      { address: address, citystatezip: citystatezip }
    )
  end

  def activate!
    toggle!(:active)
  end

  def deactivate!
    toggle!(:active)
  end

  def calculate_score
    weighted_total = FeatureType.sum(:weight)
    weighted_sum   = features.map {|feature| feature.score * feature.weight}.sum
    score = (weighted_sum.to_f / weighted_total.to_f)
    self.score = score
    save!
  end
end
