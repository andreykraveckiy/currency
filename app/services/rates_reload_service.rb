require 'open-uri'
require 'csv'

CSV_URI = 'https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
HEADER_SIZE = 5

class RatesReloadService
	attr_reader :data

	def initialize(csv_file = nil)
		@csv_file = csv_file
	end

	def perform
		@csv_file ||= csv_load_from_uri
		fill_in_db
	end

	private

		def csv_load_from_uri
			open(CSV_URI)		
		end

		def fill_in_db
			@data = CSV.read(@csv_file)[HEADER_SIZE..-1] 
			@data.reverse.each do |row|
				EurUsdRate.create(date: row[0], currency: row[-1])
			end
		end
end