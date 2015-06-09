class AddDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :date_to_receive, :date
    add_column :users, :status, :string
  end
end
