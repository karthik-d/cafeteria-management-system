class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :diet_type     # use validates_inclusion_of (veg, egg, non-veg)
      t.datetime :updated_at, :default => DateTime.now
      t.datetime :archived_at, :default => nil
    end
  end
end
