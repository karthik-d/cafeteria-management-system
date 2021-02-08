class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :role
      t.string :email
      t.string :password_digest
      t.string :mobile_num
      t.datetime :updated_at, :default => DateTime.now
      t.datetime :archived_at, :default => nil
    end
  end
end
