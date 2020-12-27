module Coinbase
  require 'coinbase/wallet'

  def client
    Coinbase::Wallet::Client.new(api_key: ENV['CB_KEY'], api_secret: ENV['CB_SECRET'])
  end

  # test data for screen shots
  def screenshot_data
    {
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
  end

end