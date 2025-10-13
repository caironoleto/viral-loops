require 'faraday'
require 'json'
require 'rack/utils'

module ViralLoops
  class Client
    API_VERSION = 'v3'

    def initialize(secret_token: ViralLoops.configuration.secret_token)
      @connection ||= Faraday.new(url: ViralLoops.configuration.api_base) do |faraday|
        faraday.headers['Content-Type'] = 'application/json'
        faraday.headers['apiToken'] = secret_token
        faraday.adapter Faraday.default_adapter
        faraday.response :logger if ViralLoops.configuration.debug
      end
    end

    def get(path, params = {})
      handle_response @connection.get(get_path(path), params)
    end

    def post(path, body = {})
      handle_response @connection.post(get_path(path), body.to_json)
    end

    private

    def get_path(path)
      "/api/#{API_VERSION}/#{path}"
    end

    def handle_response(response)
      case response.status
      when 200..299 then JSON.parse(response.body)
      else
        status_symbol = Rack::Utils::SYMBOL_TO_STATUS_CODE.key(response.status)
        default_message = Rack::Utils::HTTP_STATUS_CODES[response.status] || "API error"

        raise ViralLoops::ApiError.new(
          body: response.body.to_s.strip.empty? ? default_message : response.body,
          status: response.status,
        )
      end
    end
  end

  class ApiError < StandardError
    attr_reader :status, :status_symbol, :body

    def initialize(status:, body: nil, message: nil)
      @status = status
      @status_symbol = Rack::Utils::SYMBOL_TO_STATUS_CODE.key(status)
      @body = body

      default_message = Rack::Utils::HTTP_STATUS_CODES[status] || 'API Error'
      super(message || "#{default_message} (#{status})")
    end
  end
end
