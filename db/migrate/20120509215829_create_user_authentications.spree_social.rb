# This migration comes from spree_social (originally 20120120163432)
class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :spree_user_authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.timestamps
    end
  end
end
