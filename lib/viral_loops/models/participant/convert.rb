# frozen_string_literal: true

module ViralLoops
  module Models
    class Participant
      class Convert
        attr_accessor :processing

        def initialize(processing:)
          @processing = processing
        end

        def processing? = !!processing
      end
    end
  end
end
