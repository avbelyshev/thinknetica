vowels = %w[a e i o u]
alphabet = "a".."z"
hash = {}

alphabet.each.with_index(1) do |l, i|
  hash[l] = i if vowels.include? l
end

puts hash
