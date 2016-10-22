require './app/services/rates_reload_service'
require './app/services/exchanger_service'

class StaticPagesController < ApplicationController
	def calculate
	end

	def compute
		@dates_cur = EurUsdRate.where("date >= :start_date AND date <= :end_date",
								{start_date: params[:start_date], end_date: params[:end_date]})
		@amount = params[:sum]
		if !@dates_cur.empty? && !@amount.empty?
			@answers = ExchangerService.exchange(params[:sum].to_f, get_currencies(@dates_cur))
		else
			flash[:error] = "Something went wrong. Please, choose another dates, check your amount or load rates form ECB!"
			redirect_to root_url
		end
	end

	def reload
		rr = RatesReloadService.new
		rr.perform
		if rr.data.empty?
			flash[:error] = "Please try in another time!"
			redirect_to root_url
		else
			flash[:success] = "Your data is updated!"
			redirect_to root_url
		end
	end

	private
		def get_currencies(dates_cur)
			res = []
			dates_cur.each { |cur| res << cur.currency }
			res
		end
end
