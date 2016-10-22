require 'spec_helper'
require 'open-uri'
require 'csv'

LOCAL_CSV = './spec/assets/data.csv'

describe RatesReloadService do
	before do
		@test_instance = RatesReloadService.new
		@test_instance.perform 
		@array = CSV.read(open(LOCAL_CSV))[HEADER_SIZE..-1]
	end

	it "should include data from local csv" do
		expect(@array - @test_instance.data).to be_empty 
	end

	describe "work with database" do
		let (:temp) { EurUsdRate.find_by(date: @array[0][0]) }

		it "should not be nil" do
			expect(temp).to_not be_nil
		end

		it "should have same date and currency" do
			expect(temp.date).to eq @array[0][0]
			expect(temp.currency.to_f).to eq @array[0][-1].to_f
		end
	end	
end