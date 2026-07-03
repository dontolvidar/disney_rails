class CreateGeneros < ActiveRecord::Migration[8.1]
  def change
    create_table :generos do |t|
      t.string :nombre
      t.string :imagen

      t.timestamps
    end
  end
end
