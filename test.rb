

require 'csv'

categories = Hash.new

CSV.foreach("lib/data/categories.csv", {:col_sep => ";"}) do |row|
  categories.merge!({row[0] => row[2]})
end

puts categories.count
puts '+---------------------+'

i = 0

CSV.foreach("lib/data/products.csv", {:col_sep => ";"}) do |row|
  i += 1

  puts row[2]
  if (row[43] == 'femme' || row[43] == 'homme, femme')
    puts categories[row[3]]
  end

  if i > 50
    break
  end
end
