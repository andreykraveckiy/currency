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

	describe "model functionality" do
		AMOUNT = 100	

		describe "Exchanger" do
			it "should return one answer" do
				expect(EurUsdRate.exchange(AMOUNT, [1.1258])) == [112.58]
			end

			it "should return more answers" do
				array = [1.2583, 1.4569, 2.8576]
				expect(EurUsdRate.exchange(AMOUNT, array)) == array.map { |el| el * AMOUNT }
			end

			# testing situation when EurUsdRate.exchange get nul is not required because this situation is filtered in page-controller
		end

		describe "Work with database: loading and store" do
			LOCAL_CSV = './spec/assets/data.csv'

			describe "before loading" do
				it "should have empty db" do
					expect(EurUsdRate.count).to eq 0
				end
			end

			describe "when file is not correct" do
				before do
					EurUsdRate.csv_file = './helpers/none'
					EurUsdRate.perform 
				end

				it "should have empty db" do
					expect(EurUsdRate.count).to eq 0
				end

				it "should have empty data" do
					expect(EurUsdRate.data).to be_empty
				end
			end

			describe "after loading" do
				before do
					EurUsdRate.csv_file = LOCAL_CSV
					EurUsdRate.perform 
				end

				let (:temp) { EurUsdRate.find_by(date: EurUsdRate.data[0][0]) }

				it "should not be nil" do
					expect(temp).to_not be_nil
				end

				it "should have same date and currency" do
					expect(temp.date).to eq EurUsdRate.data[0][0]
					expect(temp.currency.to_f).to eq EurUsdRate.data[0][-1].to_f
				end
			end
		end
	end
end
