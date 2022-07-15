# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

puts "Test Guru (version #{Rails.application.config.version}) has been initialized successfully"
