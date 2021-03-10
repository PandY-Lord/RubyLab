def put_data
  puts 'Введите число и строку'
  words = gets.chomp
  words = words.split(" ")
  word = words[1]

  if word[word.length - 2, word.length - 1].upcase == "CS"
    puts 2 ** word.length
  else
    puts word.reverse
  end

end

def pokemon_processor
  pokemons =[]
  puts 'Введите количество покемонов'
  number = gets.to_i
  number.times do
    puts 'Pokemon name'
    name1 = gets.chomp
    puts 'Color'
    color1 = gets.chomp
    pokemons << {'name' => name1, 'color' => color1}
  end
  puts 'Массив'
  puts pokemons
end
def menu
  loop do
    puts '1. Число и строка'
    puts '2. Хеш покемонов'
    puts '3. Выход'
    puts "\n"


    choose = gets.to_i
    case choose
    when 1
      put_data
    when 2
      pokemon_processor
    when 3
      break
    else
      puts "Введен неправильный вариант"
    end
  end
  end

menu
