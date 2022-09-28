class PopulateTestQuestionsCount < ActiveRecord::Migration[6.1]
  def change
    Test.find_each do |test|
      Test.reset_counters(test.id, :questions)
    end
  end
end
