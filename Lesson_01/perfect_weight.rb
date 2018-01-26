puts "Введите Ваше имя:"
name = gets.chomp

puts "Введите Ваш рост (в см):"
height = gets.to_i

perfect_weight = height - 110

if perfect_weight > 0
  puts "#{name}, Ваш идеальный вес #{perfect_weight} кг."
else
  puts "#{name}, Ваш вес уже оптимальный."
end
