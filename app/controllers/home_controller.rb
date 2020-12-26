class HomeController < ApplicationController
  require 'coinbase/wallet'

  def index

    # test data for screen shots
    # right now theres only a test param. if want real data, you dont send a param
    if params[:env].present? && params[:env] == "test"

      @current_standings = {
        net_profit: 1000,
        accounts: [
          {
            amount_vested: 800,
            wallet: 'BTC',
            current_value:  1600,
            difference: 800
          },
          {
            amount_vested: 400,
            wallet: 'ETH',
            current_value:  600,
            difference: 200
          },
          {
            amount_vested: 200,
            wallet: 'LTC',
            current_value:  0,
            difference: -200
          }
        ]
      }
      return
    end

    client = Coinbase::Wallet::Client.new(api_key: ENV['CB_KEY'], api_secret: ENV['CB_SECRET'])

    # client accounts that have money invested in them [btc, eth, ltc...]
    vested_accounts = client.accounts.select {|a| a['native_balance']['amount'].to_i > 0}
    account_statuses = vested_accounts.map do |account|
      av = account.transactions.map {|t| t['native_amount']['amount'].to_i}.reduce(0, :+)
      cv = account['native_balance']['amount'] # the value you could trade at

      {
        amount_vested: av,
        wallet: account['name'].split(" ")[0],
        current_value:  cv,
        difference: cv.to_i - av.to_i
      }
    end

    @current_standings = {
      net_profit: account_statuses.map{|av| av[:difference]}.reduce(0, :+),
      accounts: account_statuses
    }

  end
end