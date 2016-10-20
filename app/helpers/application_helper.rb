require 'open-uri'
require 'csv'
module ApplicationHelper
	url = 'https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv'
	def perform_read
		open(url) do |f|
			f.each_line do |line|
				data = CSV.parse f
			end
		end	
		data	
	end
end
