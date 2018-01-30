basket = {}
sum = 0

puts "Для завершения покупки введите \"стоп\""

loop do
  puts "Введите наименование товара:"
  name = gets.chomp

  break if name.downcase == "стоп"

  puts "Введите цену:"
  price = gets.to_f

  puts "Введите количество:"
  quantity = gets.to_f

  basket[name] = {price: price, quantity: quantity}
  sum += price * quantity
end

puts "Ваши покупки:\n"

basket.each do |name, product_params|
  price = product_params[:price]
  quantity = product_params[:quantity]
  puts "Наименование: #{name}"
  puts "Цена: #{price}"
  puts "Количество: #{quantity}"
  puts "Сумма : #{price * quantity}\n"
end

puts "На сумму: #{sum}"
