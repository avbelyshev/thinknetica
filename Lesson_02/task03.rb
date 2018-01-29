array = [0, 1]

loop do
  num = array[-1] + array[-2]
  break if num > 100
  array << num
end

puts array.to_s
