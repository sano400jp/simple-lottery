class RenameGestCodeColumnToLotteries < ActiveRecord::Migration
  def change
    rename_column :lotteries, :gest_code, :guest_code
  end
end
