class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false
      t.string :email,              null: false
    end

    add_index :users, :email, unique: true

    # TODO если убрать default: '' см ниже, то rake:migrate выдает ошибку на эту строчку
    add_column :users, :name, :string, null: false, default: '%username%'
    add_column :users, :sex, :string, null: false, default: 'Неизвестно'
    add_column :users, :permission, :integer, null:false, default: 3
  end
end