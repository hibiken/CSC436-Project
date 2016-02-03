class ApiConstraints
  def initialize(version:, default: false)
    @version = version
    @default = default
  end

  def matches?(request)
    @default || check_headers(request.headers)
  end

  private

    def check_headers(headers)
      accept = headers['Accept']
      accept && accept.include?("application/vnd.socialmedia.v#{@version}+json")
    end
end
