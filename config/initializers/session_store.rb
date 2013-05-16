# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stock_session',
  :secret      => 'a94a52509c1f0118c5639b9f1259a11061b249151aeb3281dee28309f2b7c0b54b6f6da2825cd55b08127668107f9d7dfa15b76615d81e0af80c9a257a9c94c4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
