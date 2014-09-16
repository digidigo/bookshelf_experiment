class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.references :user, index: true, :null => false
      t.references :book, index: true, :null => false

      t.timestamps
    end
  end

end
