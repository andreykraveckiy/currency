require 'spec_helper'

describe "StaticPagesController" do

	subject { page }

	describe "Calculate page" do
		before { visit root_path }

		it { should have_content('EUR/USD') }
	end

end
