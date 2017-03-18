module CommentsHelper
  def hex_color_for(string)
    valid_hex_letters = ("a".."f").to_a
    first_letter = string[0].downcase
    hex = string.downcase.strip.unpack("H*").first
    case 
    when hex.length >= 6
      hex = hex[0..5]
    when hex.length < 6
      (6 - hex.length).times { hex += (("A".."F").to_a | ("0".."9").to_a).sample }
    end
    modified_first_letter_index = ("a".."z").to_a.index(first_letter) % 6
    modified_first_letter = valid_hex_letters[modified_first_letter_index]
    
    return_value = "##{hex}"
    return_value[1] = modified_first_letter
    return_value
  end
end
