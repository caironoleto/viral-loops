# frozen_string_literal: true

module ViralLoops
  class Configuration
    attr_accessor :api_base, :campaign_id, :debug, :secret_token

    def initialize
      @api_base = 'https://app.viral-loops.com'
    end
  end
end
