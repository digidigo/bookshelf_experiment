class CreatePeopleUsers < ActiveRecord::Migration
  def change
    create_table :people_users do |t|
      t.string :username, :null => false
      t.timestamps
    end
  end
end
