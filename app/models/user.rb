class User < ApplicationRecord

  include Coinbase

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  def portfolio_status
    # client accounts that have money invested in them [btc, eth, ltc...]
    vested_accounts = client.accounts.select {|a| a['native_balance']['amount'].to_i > 0}
    account_statuses = vested_accounts.map do |account|
      av = account.transactions.map {|t| t['native_amount']['amount'].to_i}.reduce(0, :+)
      cv = account['native_balance']['amount'].to_i # the value you could trade at

      {
        amount_vested: av,
        wallet: account['name'].split(" ")[0],
        current_value:  cv,
        percent_change: (((cv - av)/av.to_f)*100).round(1),
        difference: cv - av
      }
    end

    gv = account_statuses.map{|av| av[:amount_vested]}.reduce(0, :+)
    vg = account_statuses.map{|av| av[:current_value]}.reduce(0, :+)

    {
      gross_vested: gv,
      vested_growth: vg,
      net_profit: account_statuses.map{|av| av[:difference]}.reduce(0, :+),
      percent_change: (((vg - gv)/gv.to_f)*100).round(1),
      accounts: account_statuses
    }
  end

  # test data for screen shots
  def test_portfolio_status
    {
      gross_vested: 1400,
      vested_growth: 2200,
      net_profit: 800,
      percent_change: (((2200 - 1400)/1400.to_f)*100).round(1),
      accounts: [
        {
          amount_vested: 800,
          wallet: 'BTC',
          current_value:  1600,
          percent_change: (((1600 - 800)/800.to_f)*100).round(1),
          difference: 800
        },
        {
          amount_vested: 400,
          wallet: 'ETH',
          current_value:  600,
          percent_change: (((600 - 400)/400.to_f)*100).round(1),
          difference: 200
        },
        {
          amount_vested: 200,
          wallet: 'LTC',
          current_value:  0,
          percent_change: (((0 - 200)/200.to_f)*100).round(1),
          difference: -200
        }
      ]
    }
  end
end
