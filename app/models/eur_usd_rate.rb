class EurUsdRate < ActiveRecord::Base
	validates :date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/}, length: { is: 10 }
	validates :currency, numericality: true
end
