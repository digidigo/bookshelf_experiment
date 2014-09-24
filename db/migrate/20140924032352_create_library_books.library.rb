# This migration comes from library (originally 20140924032251)
class CreateLibraryBooks < ActiveRecord::Migration
  def change
    create_table :library_books do |t|
      t.string :title,:null => false
      t.timestamps
    end
  end
end
