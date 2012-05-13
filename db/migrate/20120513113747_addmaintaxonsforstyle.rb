class Addmaintaxonsforstyle < ActiveRecord::Migration
  def up
    taxonomy = Spree::Taxonomy.create(:name => 'Univers')
    taxon_last_id = Spree::Taxon.last.id
    Spree::Taxon.create(:parent_id => taxon_last_id, :name => 'Baba')
    Spree::Taxon.create(:parent_id => taxon_last_id, :name => 'Fashion Girl')
    Spree::Taxon.create(:parent_id => taxon_last_id, :name => 'Student Style')
    Spree::Taxon.create(:parent_id => taxon_last_id, :name => 'Trendy')
    Spree::Taxon.create(:parent_id => taxon_last_id, :name => 'Working Girl')
  end

  def down
    Spree::Taxonomy.find_by_name('Univers').delete
  end
end
