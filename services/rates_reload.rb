require 'open-uri'
require 'csv'

class RatesReload
	attr_reader :data

	def initialize
		file_csv = open('https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv')
		@data = CSV.parse(file_csv)
	end
end