class ApplicationController < ActionController::API
    def auth_header
        request.headers['Authorization']
    end

    def encode_token(payload)
        JWT.encode(payload,ENV['APP_SECRET'])
end
