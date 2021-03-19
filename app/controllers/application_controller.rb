class ApplicationController < ActionController::API
    def auth_header
        request.headers['Authorization']
    end

    def encode_token(payload)
        JWT.encode(payload,ENV['APP_SECRET'])
    end

    def decode_token(token)
        if auth_header
            begin
                JWT.decode(token, ENV['APP_SECRET'])[0]
            rescue JWT::DecodeError
                nil
            end
        end
    end
end
