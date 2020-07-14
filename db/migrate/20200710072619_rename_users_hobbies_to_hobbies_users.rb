class RenameUsersHobbiesToHobbiesUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_table :users_hobbies, :hobbies_users
  end
end
