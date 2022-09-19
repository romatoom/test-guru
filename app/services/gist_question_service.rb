class GistQuestionService
  attr_reader :question, :client, :test, :gist

  def initialize(question, client: nil)
    @question = question
    @client = client || GitHubClient.new
    @test = @question.test
    @gist = nil
  end

  def call
    result = client.create_gist(gist_params)

    self.gist = { success: true, gist_url: result["html_url"] }
  rescue
    self.gist = { success: false, gist_url: nil }
  end

  def gist_successfully_created?
    gist[:success] if gist.present?
  end

  def gist_url
    gist[:gist_url] if gist.present?
  end

  private

  attr_writer :gist

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

