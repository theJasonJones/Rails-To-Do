class TodoList < ActiveRecord::Base
	#Validate and make sure title is filled
	validates :title, presence: true
	validates :title, length: {minimum: 3}
	validates :description, presence: true
	validates :description, length: {minimum: 5}
end
