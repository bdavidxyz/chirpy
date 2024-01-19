require 'uri'

def replace_img
  Dir.glob('./_posts/*.md').each do |fichier|
    # Lire le contenu du fichier
    contenu = File.read(fichier)

    unless contenu.include?("date: 2024-")
      # Extraire la valeur de la propriété "title"
      title_match = contenu.match(/title:\s*(.+)/)
      title = title_match ? title_match[1] : "default_title"
      p title

      tags_match = contenu.match(/tags:\s*(.+)/)
      subtitle = tags_match && tags_match[0] && tags_match[0].include?('rails') ? 'A Ruby-on-Rails tutorial' : 'A simple article about Ruby'
      p subtitle

      img_url = generate_image_url(title, subtitle)
      p img_url
      p '_____________'

      # Remplacer la valeur de la propriété "path" par le contenu de "title" suivi de ".jpg"
      # contenu.gsub!(/(path:)\s*(.+)$/, "\\1 #{title.strip.downcase.gsub(/\s+/, '_')}.jpg")

      # Écrire les modifications dans le fichier
      # File.write(fichier, contenu)
    end

  end
end

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


# Launch !!!
replace_img()
