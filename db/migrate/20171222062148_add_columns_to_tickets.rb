class AddColumnsToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :guest_code, :string
  end
end
