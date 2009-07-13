# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_seinfeldr_session',
  :secret      => '1b997b8f6cab72580d4b69646c8b56172e7047e9c69ae7af969c7a72b814d1e417d665897cb827b09f2764d27dc12e69b373a2b4a58069d54619f25f71294a94'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
