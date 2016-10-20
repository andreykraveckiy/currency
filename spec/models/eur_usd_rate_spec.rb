require 'spec_helper'

describe EurUsdRate do
  let(:time_currency) { EurUsdRate.new(date: "2016-10-21", currency: "1.5000") }

  subject { time_currency }

  it { should respond_to(:date) }
  it { should respond_to(:currency) }
end
