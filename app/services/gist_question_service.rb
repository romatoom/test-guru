class GistQuestionService
  attr_reader :question, :client, :test

  def initialize(question, client: nil)
    @question = question
    @client = client || GitHubClient.new
    @test = @question.test
  end

  def call
    result = client.create_gist(gist_params)

    { success: true, gist_url: result["html_url"] }
  rescue
    { success: false, gist_url: nil }
  end

  private

  def gist_params
    {
      description: "A question about \"#{test.title}\" test",
      public: true,
      files: {
        "test-guru-question.txt": {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [question.body]
    content << question.answers.pluck(:body).map{|a| " - #{a}"}
    content.join("\n")
  end
end

