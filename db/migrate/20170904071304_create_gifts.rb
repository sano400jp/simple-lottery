class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :lottery_code
      t.string :name
      t.integer :start_cnt
      t.integer :delived_cnt
      t.string :image_l_url
      t.string :image_m_url
      t.string :image_s_url

      t.timestamps null: false
    end
  end
end
