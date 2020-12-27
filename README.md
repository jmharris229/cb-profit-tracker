# CB Profit Tracker

Built with Rails, Docker, Coinbase API, and Postgres.

This app is designed to sum all transactions based on your holdings in Coinbase and provide a net balance on your position.

if you want to use this for yourself...
1. Clone the repo
2. Set up a Coinbase account and register an API KEY
3. Create a .env.local file and add export variables for the PG_PASSWORD, CB_KEY, CB_SECRET
4. run `docker-compose up`