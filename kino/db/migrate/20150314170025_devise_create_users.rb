class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.integer :permission, null: false, default: 2
    end

    add_index :users, :email,                unique: true
  end
end
