class Trainer < ApplicationRecord
	before_save { email.downcase! }

	has_many :pokemons
	validates :name, presence: true,
					length: { maximum: 45 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 45 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
  	validates :password, presence: true, length: { minimum: 6, maximum: 45 }
end
