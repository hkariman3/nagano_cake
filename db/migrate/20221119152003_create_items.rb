class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id
      t.string:name
      t.text:introduction
      t.integer:price
      t.boolean:is_active, null: false, default: TRUE

      t.timestamps
    end
  end
end
