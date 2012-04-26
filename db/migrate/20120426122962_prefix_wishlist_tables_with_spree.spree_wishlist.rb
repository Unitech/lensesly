# This migration comes from spree_wishlist (originally 20111130204731)
class PrefixWishlistTablesWithSpree < ActiveRecord::Migration
  def change
    rename_table :wishlists, :spree_wishlists
    rename_table :wished_products, :spree_wished_products
  end
end
