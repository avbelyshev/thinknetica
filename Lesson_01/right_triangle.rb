puts "Введите длины сторон треугольника"
puts "Cторона A"
a = gets.to_f

puts "Cторона B"
b = gets.to_f

puts "Cторона C"
c = gets.to_f

cathetus1, cathetus2, hypotenuse = [a, b, c].sort

rectangular = hypotenuse**2 == (cathetus1**2 + cathetus2**2)
isosceles = cathetus1 == cathetus2
equilateral = isosceles && cathetus1 == hypotenuse

result = "Треугольник "
result += "прямоугольный" if rectangular
result += " и " if rectangular && isosceles
result += "равнобедренный" if isosceles
result += " и равносторонний" if equilateral
result += "не прямоугольный и не равнобедренный" if !rectangular && !isosceles

puts result
