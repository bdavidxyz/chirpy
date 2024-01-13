require 'uri'

# <a href="foo" target="_blank">foo</a>

def generate_image_url(title, subtitle)
  base_url = "https://res.cloudinary.com/bdavidxyz-com/image/upload"
  image_options = "/w_1600,h_836,q_100"

  title_text = "/l_text:Karla_72_bold:#{URI::Parser.new.escape(title)},co_rgb:ffe4e6,c_fit,w_1400,h_240"
  subtitle_text = "/l_text:Karla_48:#{URI::Parser.new.escape(subtitle)},co_rgb:ffe4e680,c_fit,w_1400"

  image_apply = "/fl_layer_apply,g_south_west,x_100,y_180"
  subtitle_apply = "/fl_layer_apply,g_south_west,x_100,y_100"

  background_image = "/newblog/globals/bg_me.jpg"

  final_url = "#{base_url}#{image_options}#{title_text}#{image_apply}#{subtitle_text}#{subtitle_apply}#{background_image}"

  return final_url.gsub('?', '%3F')
end

# Demander le titre et le sous-titre à l'utilisateur
puts "Entrez le titre :"
titre = gets.chomp

puts "Entrez le sous-titre :"
sous_titre = gets.chomp

# Générer l'URL et l'afficher
puts generate_image_url(titre, sous_titre)
