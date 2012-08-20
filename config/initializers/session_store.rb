# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ajaxtree_session',
  :secret      => '75fd1ac16fbb4998cb2a2aac2456f25318b0fbb1cf1b2a51c94f93e8aca7540a8a19a509a623cf0f7d5a73d288642b2d67b3c5575a5f6bbbe37b69e5d52bbd38'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
