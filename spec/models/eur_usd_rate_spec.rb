require 'spec_helper'

describe EurUsdRate do
  let(:time_currency) { EurUsdRate.new(date: "2016-10-21", currency: 1.5000) }

  subject { time_currency }

  it { should respond_to(:date) }
  it { should respond_to(:currency) }

  it { should be_valid }

  describe "date field" do
  	describe "when date is not present" do
	  	before { time_currency.date = '' }
	  	it { should be_invalid }
		end

		describe "when date is too long" do
			before { time_currency.date = '2016-10-21 ' }
			it { should be_invalid }
		end

		describe "when date is too short" do
			before { time_currency.date = '2016-10-2' }
			it { should be_invalid }
		end

		describe "when date format is invalid" do
			it "should be invalid" do
				dates = %w[20-1610-21 20-16-1021 201-610-21 2016.10.21 aaaa-10-21]

				dates.each do |invalid_date|
					time_currency.date = invalid_date
					expect(time_currency).to be_invalid
				end
			end
		end
  end

  describe "currency field" do
  	describe "when currency is not present" do
  		before { time_currency.currency = '' }
  		it { should be_invalid }
		end

		describe "when currency is invalid" do
			before { time_currency.currency = '1,2568' }
			it { should be_invalid }
		end
  end
end
