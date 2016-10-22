require 'spec_helper'
require 'open-uri'
require 'csv'

LOCAL_CSV = './spec/assets/data.csv'

describe RatesReloadService do
	describe "work with database" do

		describe "before loading" do
			it "should have empty db" do
				expect(EurUsdRate.count).to eq 0
			end
		end

		describe "after loading" do
			before do
				@test_instance = RatesReloadService.new(LOCAL_CSV)
				@test_instance.perform 
			end

			let (:temp) { EurUsdRate.find_by(date: @test_instance.data[0][0]) }

			it "should not be nil" do
				expect(temp).to_not be_nil
			end

			it "should have same date and currency" do
				expect(temp.date).to eq @test_instance.data[0][0]
				expect(temp.currency.to_f).to eq @test_instance.data[0][-1].to_f
			end
		end
	end	
end