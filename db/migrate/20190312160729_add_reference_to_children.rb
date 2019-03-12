class AddReferenceToChildren < ActiveRecord::Migration[5.2]
def change
  add_reference :children, :profile, foreign_key: true
end
end
