class Post < ApplicationRecord
	belongs_to :user
	has_one_attached :image
	validate :image_presence
	has_many :comments, as: :commentable
	has_many :likes, as: :likeable 


  def image_presence
    errors.add(:image, "can't be blank") unless image.attached?
  end

 	def image_url
 		Rails.application.routes.url_helpers.url_for(self.image)
 		# self.image.service_url
 	end
end
