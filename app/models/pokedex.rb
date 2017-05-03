class Pokedex < ApplicationRecord
	validates :name, presence: true,
					length: {maximum: 45}
	validates :base_health_point, presence: true,
									numericality: { :greater_than_or_equal_to => 0 }
	validates :base_attack, presence: true,
							numericality: { :greater_than_or_equal_to => 0 }
	validates :base_defence, presence: true,
							numericality: { :greater_than_or_equal_to => 0 }
	validates :base_speed, presence: true,
							numericality: { :greater_than_or_equal_to => 0 }
	validates :element_type, presence: true,
							length: {maximum: 45}
	validates :image_url, presence: true,
	 					format: { with: URI.regexp }
end
