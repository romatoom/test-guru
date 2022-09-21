class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @client = client || GitHubClient.new
    @test = @question.test
    @response = nil
  end

  def call
    self.response = client.create_gist(gist_params)
  end

  def success?
    response&.status == 201
  end

  def gist
    JSON.parse(response&.body)
  end

  private

  attr_accessor :response
  attr_reader :question, :client, :test

  def gist_params
    {
      description: I18n.t("services.gist_question_service.description", test_title: test.title),
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

