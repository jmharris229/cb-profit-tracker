module Coinbase
  require 'coinbase/wallet'
  extend ActiveSupport::Concern

  def client
    Coinbase::Wallet::Client.new(api_key: ENV['CB_KEY'], api_secret: ENV['CB_SECRET'])
  end

end