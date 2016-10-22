require 'spec_helper'

describe ExchangerService do
	AMOUNT = 100	
	describe "get one amount" do
		it "should return one answer" do
			expect(ExchangerService.exchange(AMOUNT, [1.1258])) == [112.58]
		end

		it "should return more answers" do
			array = [1.2583, 1.4569, 2.8576]
			expect(ExchangerService.exchange(AMOUNT, array)) == array.map { |el| el * AMOUNT }
		end
	end
end