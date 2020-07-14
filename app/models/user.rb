class User < ApplicationRecord
	before_save :downcase_email
	has_many :microposts, dependent: :destroy
	has_and_belongs_to_many :hobbies
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	with_options presence: true do |user|
		user.validates :name, length: { maximum: 20 }
		user.validates :email, length: { maximum: 50 },
						  format: { with: VALID_EMAIL_REGEX },
						  uniqueness: true, confirmation: true
		user.validates :password, length: { minimum: 4 }
	end
	has_secure_password

	private

	def downcase_email
		self.email = email.downcase
	end

	def self.search(search)
		if search
			User.all.where('name LIKE ?',"%#{search}%")
		else
			User.all
		end
	end
end
