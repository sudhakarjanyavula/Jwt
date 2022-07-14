class Comment < ApplicationRecord
   belongs_to :user
   belongs_to :commentable, polymorphic: true, optional: true
   has_many :likes, as: :likeable
end
