class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :avatar
      t.string :username
      t.string :role
      t.string :password_digest

      t.timestamps
    end
  end
end
