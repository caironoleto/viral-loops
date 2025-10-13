module ViralLoops
  module Resources
    class Participants < Client
      BASE_PATH = "campaign/participant"

      def create(params)
        response = post(BASE_PATH, params)

        Models::Participant.new(referral_code: response["referralCode"], new: response["isNew"])
      end
    end
  end
end
