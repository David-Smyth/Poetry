class AddLcEmailIndecToUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: :email
    add_column   :users, :lc_email, :string
    add_index    :users, :lc_email, unique: true
  end
end
