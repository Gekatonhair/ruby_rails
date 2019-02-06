class AddUserRefToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :user, foreign_key: true
  end
end
# add_column :users, :subscribe, :bigint, array: true, default: []