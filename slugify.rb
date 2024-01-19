require 'uri'

def to_slug(input_string)
  # Remplace les espaces par des tirets
  slug = input_string.gsub(/\s+/, '-')

  # Supprime les caractères spéciaux
  slug = slug.downcase.gsub(/[^\w-]/, '')

  return slug
end


# Demander la chaîne
puts "Entrez la str :"
given_str = gets.chomp

# Générer le slug et l'afficher
puts to_slug(given_str)
