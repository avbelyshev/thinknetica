puts "Введите A"
a = gets.to_f

puts "Введите B"
b = gets.to_f

puts "Введите C"
c = gets.to_f

discr = b**2 - 4 * a * c
sqrt = Math.sqrt(discr)

if discr > 0
  x1 = (-b + sqrt) / (2 * a)
  x2 = (-b - sqrt) / (2 * a)
  puts "Дискриминант: #{discr}, x1: #{x1}, x2: #{x2}"
elsif discr == 0
  x1 = -b / (2 * a)
  puts "Дискриминант: #{discr}, x1: #{x1}"
else
  puts "Корней нет"
end
