class OctokitClientAdapter < GitHubClient
  def initialize(octokit_client)
    @octokit_client = octokit_client
  end

  def create_gist(params)
    octokit_client.create_gist(params)
  ensure
    return octokit_client.last_response
  end

  private

  attr_reader :octokit_client
end
