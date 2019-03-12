class Child < ApplicationRecord
	belongs_to :profile
	enum sex: { girl:1, boy:2 }
end
