class AddColumnFieldsUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :addres, :string
    add_column :users, :phone, :string
  end
end
