class StaticPagesController < ApplicationController
	def calculate
	end

	def compute
		dates_cur = EurUsdRate.where("created_at >= :start_date AND created_at <= :end_date",
								{start_date: params[:start_date], end_date: params[:end_date]})
		redirect_to root_url unless dates_cur
	end
end
