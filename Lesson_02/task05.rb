months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Введите номер года:"
year = gets.to_i

months[1] = 29 if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

puts "Введите номер месяца:"
month = gets.to_i

abort "Номер месяца должен быть в интервале от 1 до 12" unless month.between?(1, 12)

puts "Введите день:"
day = gets.to_i

max_day = months[month - 1]
abort "День должен быть в интервале от 1 до #{max_day}" unless day.between?(1, max_day)

days = 0

(month - 1).times do |i|
  days += months[i]
end

days += day

puts "Порядковый номер даты с начала года: #{days}"
