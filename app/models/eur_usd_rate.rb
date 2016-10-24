require 'open-uri'
require 'csv'

CSV_URI = 'https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
HEADER_SIZE = 5

class EurUsdRate < ActiveRecord::Base
	validates :date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/}, length: { is: 10 }, uniqueness: true
	validates :currency, numericality: true

	cattr_reader :data # for checking data

	def EurUsdRate.perform
		@@data = []
		@csv_file ||= csv_load_from_uri
		fill_in_db
	end

	def EurUsdRate.exchange(sum, rates)
		rates.map { |el| el * sum } 
	end

	def EurUsdRate.csv_file=(file)
		@csv_file = file
	end

	private

		def EurUsdRate.csv_load_from_uri
			begin
				open(CSV_URI)		
			rescue
			end
		end

		def EurUsdRate.fill_in_db
			begin
				@@data = CSV.read(@csv_file)[HEADER_SIZE..-1] 
				@@data.reverse.each do |row|
					EurUsdRate.create(date: row[0], currency: row[-1])
				end
			rescue
			end
		end
end
