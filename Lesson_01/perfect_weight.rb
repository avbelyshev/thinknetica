puts "Введите Ваше имя:"
name = gets.chomp

puts "Введите Ваш рост (в см):"
height = gets.to_i

perfect_weight = height - 110

result = "#{name}, "
result += "Ваш идеальный вес #{perfect_weight} кг." if perfect_weight > 0
result += "Ваш вес уже оптимальный." if perfect_weight <= 0

puts result
