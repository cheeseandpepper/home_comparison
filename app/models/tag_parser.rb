class TagParser

  attr_reader :description

  def initialize(description)
    @description = description
  end

  def create!
    home_style_tags
    garage_tags
    backyard_tags
    bonus_tags
    miscelaneous_tags
  end

  def home_style_tags
    tags = [
      "spanish",
      "craftsman",
      "mid-century",
      "modern",
      "victorian",
      "bungalo",
      "artist",
      "cottage"
    ]
  end

  def garage_tags
    
  end

  def backyard_tags
    
  end

  def bonus_tags
    
  end

  def miscelaneous_tags
    
  end

end