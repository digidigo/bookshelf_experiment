class CreateBookshelfOwnerships < ActiveRecord::Migration
  def change
    create_table :bookshelf_ownerships do |t|
      t.references :people_user, index: true, :null => false
      t.references :library_book, index: true, :null => false
      t.timestamps
    end
    
    add_index(:bookshelf_ownerships, [:people_user_id, :library_book_id], :unique => true, :name => "udx_people_book")
  end
end
