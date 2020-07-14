class CreateHobbiesAndUsersAssociation < ActiveRecord::Migration[5.2]
  def change
    create_table :hobbies do |t|
      t.string :name

      t.timestamps
    end

    create_table :users_hobbies, id: false do |t|
    	t.belongs_to :user
    	t.belongs_to :hobby
    end
  end
end
