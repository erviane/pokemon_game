class Pokemon < ApplicationRecord
	belongs_to :pokedex
	validates :name, presence: true,
						length: {maximum: 45}
	validates :pokedex_id, presence: true
end
