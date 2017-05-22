class Trainer < ApplicationRecord
	before_save { email.downcase! }

	has_many :pokemons, dependent: :destroy
	validates :name, presence: true,
					length: { maximum: 45 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 45 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
  	validates :password, presence: true, length: { minimum: 6, maximum: 45 }
	validate :max_pokemon_have

	def max_pokemon_have
		errors.add(:base, "can't have more than 5 Pokemons") if self.pokemons.count >= 5
	end
end
