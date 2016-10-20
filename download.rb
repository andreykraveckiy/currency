module MyStuff
	require 'open-uri'
	require 'csv'

	def MyStuff.read(url)
		open(url) do |f|
			f.each_line do |line|
				data = CSV.parse f
			end
		end	
		p data	
	end

	def MyStuff.start
		MyStuff.read('https://sdw.ecb.europa.eu/quickviewexport.do?SERIES_KEY=120.EXR.D.USD.EUR.SP00.A&type=csv')
	end
end