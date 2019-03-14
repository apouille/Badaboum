class AddIndexToComments < ActiveRecord::Migration[5.2]
  def change
 		add_reference :comments, :user, foreign_key: true, index:true
 		add_reference :comments, :product, foreign_key: true, index:true
  end
end
