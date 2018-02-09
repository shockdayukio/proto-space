# require 'devise'
# require File.expand_path("spec/support/controller_macros.rb")
# RSpec.configure do |config|
#   config.expect_with :rspec do |expectations|
#     expectations.include_chain_clauses_in_custom_matcher_descriptions = true
#   end
#   config.mock_with :rspec do |mocks|
#     mocks.verify_partial_doubles = true
#   end
#   config.shared_context_metadata_behavior = :apply_to_host_groups
#   config.include Devise::Test::ControllerHelpers, type: :controller
#   config.extend ControllerMacros, type: :controller
# end


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
