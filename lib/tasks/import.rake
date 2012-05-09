# -*- coding: utf-8 -*-
namespace :spree do
  desc "Export Products to CSV File"
  task :export_products => :environment do
    require 'csv'

    products = Spree::Product.find(:all)
    puts "Exporting to #{Rails.root}/products2.csv"
    CSV.open("#{Rails.root}/products.csv", "w") do |csv|
    
      csv << ["id", "name", "description","sku", "master_price" ]

      products.each do |p|
        csv << [p.id,
                p.name.titleize,
                p.description,
                p.sku,
                p.price.to_s]
      end
    end
    puts "Export Complete"
  end
  
  desc "Update / Import products from CSV File, expects file=/path/to/import.csv"
  task :import_products => :environment do
    require 'csv'

    puts "Deleting"

    Spree::Product.all.each do |p|
      p.delete
    end

    Spree::Taxonomy.all.each do |p|
      p.delete
    end

    Spree::Taxon.all.each do |p|
      p.delete
    end

    puts "Creating Taxonomy"


    categories = Hash.new

    taxonomy = Spree::Taxonomy.create(:name => 'Categories')
    taxon_last_id = Spree::Taxon.last.id

    CSV.foreach("#{Rails.root}/lib/data/categories.csv", {:col_sep => ";"}) do |row|
      taxon = Spree::Taxon.create(:parent_id => taxon_last_id, :name => row[2])
      categories.merge!({row[0] => {"name" => row[2], "taxon" => taxon}})
    end

    puts categories
    puts "Creating product"

    CSV.foreach("#{Rails.root}/lib/data/products.csv", {:col_sep => ";"}) do |row|

      #puts row[2].split(' - ', 2)[1].gsub('/', '')
      next if row[2].nil?

      tmp = row[2].split(' - ', 2)[1].gsub('/', '') + '.png'

      puts tmp
      image = tmp

      #path = "#{Rails.root}/images/" + image;

      # if File.exist?(path) and (row[43] == 'femme' || row[43] == 'homme, femme')
      if (row[43] == 'femme' || row[43] == 'homme, femme')
        
        prod = Spree::Product.new :meta_keywords => row[23],
             :name => row[2],
             :available_on => Time.now,
             :price => row[4].to_i,
             :meta_description => row[22],
             :description => row[22],
             :sku => row[12]
        
        prod.save
        prod_v = Spree::Variant.last
                  prod.taxons << categories[row[3]]["taxon"]
        begin

          puts "=-===================== > Success !"
        rescue
          prod.taxons << categories[row[47]]["taxon"]
        end

        prod_v.save
        
        # prod_v.images << Spree::Image.create(:attachment => File.open("#{Rails.root}/images/" + image), :alt => row[2])
      end
      
      
      #:on_hand => 100                   
      # 0 = id
      # 2 = ref
      # 3 = category id
      # 4 = price
      # 12 = ref #2
      # 13 = ref #3
      # 15 = brand
      # 21 = lunette type Lunettes de vue amandes en Métal pour femme
      # 22 = description
      # 23 = tags Métal,Marron,femme,Agnès B.
      # 33 = image row[33]["http://hec1.pastorino.me/images/"] = ""
      # 38 = color
      # 39 = oui/non ?
      # 40 = oui/non ?
      # 41 <-> 43 = sexe/style/type
      # 42 = style de lunette
      # 44 / 45 / 46 = chiffres ?
      # 49 = materiaux
      # 50 = forme
      #puts row[52]
      # row[2] useless
      
    end

    Spree::Taxon.all
    
  end
end
