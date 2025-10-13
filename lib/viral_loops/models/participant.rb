# frozen_string_literal: true

module ViralLoops
  module Models
    class Participant
      attr_accessor :referral_code, :new

      def initialize(referral_code:, new: false)
        @referral_code = referral_code
        @new = new
      end

      def new? = new
    end
  end
end
