class AddProfileToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :position, :string
    add_column :users, :school, :string
    add_column :users, :interest, :string
  end
end
