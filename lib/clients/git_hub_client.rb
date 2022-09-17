class GitHubClient
  ROOT_ENDPOINT = 'https://api.github.com'.freeze
  ACCESS_TOKEN = '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'.freeze

  def initialize
    @http_client = setup_http_client
  end

  def create_gist(params)
    result = @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{ACCESS_TOKEN}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end

    JSON.parse(result.body)
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end
end

