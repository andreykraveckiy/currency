class Exchanger
	def Exchanger.exchange(sum, rates)
		res = []
		rates.each { |rate| res << (rate.to_f * sum) }
		res
	end
end