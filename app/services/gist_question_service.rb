class GistQuestionService
  attr_reader :question, :client, :test, :gist

  def initialize(question, client: nil)
    @question = question
    @client = client || GitHubClient.new
    @test = @question.test
    @gist = nil
  end

  def call
    self.gist = client.create_gist(gist_params)
    p self.gist
  rescue
    self.gist = nil
  end

  def gist_attr_value(attr_name)
    gist[attr_name] || gist[attr_name.to_sym] if gist.present?
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

