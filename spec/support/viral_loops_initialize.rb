# frozen_string_literal: true

require 'viral_loops'

ViralLoops.configure do |config|
  config.campaign_id = 'foo'
  config.secret_token = 'bar'
  config.debug = false
end
