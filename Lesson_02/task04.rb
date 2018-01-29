vowels = %w[a e i o u]
alphabet = ("a".."z")
hash = {}

alphabet.each.with_index do |l, i|
  i += 1
  hash[l] = i if vowels.include? l
end

puts hash
