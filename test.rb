

require 'csv'

categories = Hash.new

CSV.foreach("lib/data/categories.csv", {:col_sep => ";"}) do |row|
  categories.merge!({row[0] => row[2]})
end

puts categories.count
puts '+---------------------+'

i = 0

require('fileutils')
FileUtils.rm_r('public/system/products')
#FileUtils.mkdir_p('public/system/products')
FileUtils.mv('public/spree/products', 'public/system')


CSV.foreach("lib/data/products.csv", {:col_sep => ";"}) do |row|
  i += 1

  if !row[2].nil?
    puts row[2].split(' - ')[0]
  end

  if (row[43] == 'femme' || row[43] == 'homme, femme')
    
  end

  if i > 500
    break
  end
end
