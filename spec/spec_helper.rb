require "bundler/setup"
require "active_asset"

Dir["./spec/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  require "rack/test"
  config.include Rack::Test::Methods, :rack

  config.after do
    ActiveAsset.instance_variable_set(:@configuration, nil) # to not interfere on other specs
  end
end
