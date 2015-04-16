class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false
      t.string :email,              null: false
      t.string :name,               null: false
    end

    add_index :users, :email, unique: true

    add_column :users, :sex, :string, null: false, default: 'Неизвестно'
    add_column :users, :permission, :integer, null:false, default: 3
  end
end