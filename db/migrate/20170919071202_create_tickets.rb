class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string   :lottery_code
      t.integer  :seq
      t.string   :token
      t.integer  :gift_seq ,default: 0
      t.boolean  :act_flg  ,default: true
      t.string   :status   ,default: "0"

      t.timestamps null: false
    end
  end
end
