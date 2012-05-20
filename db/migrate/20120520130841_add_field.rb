class AddField < ActiveRecord::Migration
  def up
    tax = Spree::Taxonomy.first.taxons.first
    parent_taxon = Spree::Taxon.create(:parent_id => tax.id, :name => 'Bonnes affaires')
  end

  def down
  end
end
