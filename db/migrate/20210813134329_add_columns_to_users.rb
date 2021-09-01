class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string
    add_column :users, :image, :string
    add_column :users, :avatar, :string
    add_column :users, :favorite_player, :string
    add_column :users, :kop_history, :integer
  end
end
