class CreateUserHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_histories do |t|
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :email
      t.string :password_digest
      t.string :mobile_num
      t.datetime :data_updated_at
      # This is not the current row updation, but is a reflection from the Users table
    end
  end
end
