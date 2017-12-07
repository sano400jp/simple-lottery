class AddColumnLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :gest_code, :string
  end
end
