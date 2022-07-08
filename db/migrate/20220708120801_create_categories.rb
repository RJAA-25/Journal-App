class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.string :theme_color, default: "#540D6E"

      t.timestamps
    end
  end
end
