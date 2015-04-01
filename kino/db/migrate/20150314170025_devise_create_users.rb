class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :login,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :email,              null: false, default: ''
      t.string :sex,                null: false, default: 'Неизвестно'
      t.integer :permission,        null: false, default: 2
    end

    add_index :users, :email, unique: true
    add_index :users, :login, unique: true
  end
end
