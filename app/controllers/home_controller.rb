class HomeController < ApplicationController
  include Coinbase

  def index
    # right now theres only a test param. if want real data, you dont send a param
    if params[:env].present? && params[:env] == "test"
      @current_standings = screenshot_data
    else
      if current_user.present?
        @current_standings = current_user.portfolio_status
      end
    end
  end
end