class CreateBeautyCompetitions < ActiveRecord::Migration
  def change
    create_table :beauty_competitions do |t|
      t.string :mail
      t.string :f_name
      t.string :l_name
      t.string :number

      t.timestamps
    end
  end
end
