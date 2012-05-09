# This migration comes from spree_social (originally 20120123163222)
class CreateAuthenticationMethods < ActiveRecord::Migration
  def change
    create_table :spree_authentication_methods do |t|
      t.string :environment
      t.string :provider
      t.string :api_key
      t.string :api_secret
      t.boolean :active

      t.timestamps
    end
  end
end
