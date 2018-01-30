array = [0, 1]

while (num = array[-1] + array[-2]) < 100
  array << num
end

puts array.to_s
