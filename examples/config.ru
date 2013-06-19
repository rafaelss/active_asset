require "active_asset/rack"

ActiveAsset.configure do |c|
  c.secret = "foo"
end

use Rack::Runtime

require "rack/cache"
use Rack::Cache,
  :verbose     => true,
  :metastore   => 'file:/tmp/rack-meta3',
  :entitystore => 'file:/tmp/rack-body3'

use Rack::ETag, nil, "public, max-age=31556926" # one year

run ActiveAsset::Rack.new
