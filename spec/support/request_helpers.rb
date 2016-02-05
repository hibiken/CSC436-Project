module Request
  module JsonHelpers
    def json(body)
      JSON.parse(body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def set_api_accept_header(version: )
      request.headers['Accept'] = "application/vnd.social-media.v#{version}+json"
    end

    def set_content_type_header(type)
      request.headers['Content-Type'] = type
    end

    def login_and_set_authorization_header_for(user)
      user.set_auth_token
      user.save
      request.headers['Authorization'] = user.auth_token
    end
  end
end
