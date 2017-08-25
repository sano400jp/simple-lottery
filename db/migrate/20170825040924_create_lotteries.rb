class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.string :code
      t.string :owner_code
      t.string :title
      t.datetime :draw_time
      t.integer :redraw_range
      t.boolean :nonres_redraw
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
