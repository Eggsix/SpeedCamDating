class AddColumnsToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :accesstoken, :string
    add_column :identities, :refreshtoken, :string
    add_column :identities, :name, :string
    add_column :identities, :email, :string
    add_column :identities, :nickname, :string
    add_column :identities, :image, :string
    add_column :identities, :phone, :string
    add_column :identities, :urls, :string
  end
end
