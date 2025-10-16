# frozen_string_literal: true

require 'viral_loops/client'
require 'viral_loops/configuration'
require 'viral_loops/resources'
require 'viral_loops/models'
require 'viral_loops/version'

require 'viral_loops/resources/participants'
require 'viral_loops/models/participant'

module ViralLoops
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end

    def participants
      @participants ||= Resources::Participants.new
    end
  end
end
