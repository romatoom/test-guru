# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

puts "Test Guru (version #{Rails.application.config.version}) has been initialized successfully"

p Test.tests_by_category_desc("Frontend")
p Test.tests_by_category_desc("Backend")
p Test.tests_by_category_desc("XXX")

user = User.first
pp user.tests_by_level(0)
pp user.tests_by_level(1)
pp user.tests_by_level(2)
