# This migration comes from people (originally 20140924031250)
class CreatePeopleUsers < ActiveRecord::Migration
  def change
    create_table :people_users do |t|
      t.string :username, :null => false
      t.timestamps
    end
  end
end
