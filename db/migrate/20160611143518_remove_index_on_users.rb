class RemoveIndexOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, :null => true
    remove_index :users, :email
  end
end
