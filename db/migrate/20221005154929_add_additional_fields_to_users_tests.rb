class AddAdditionalFieldsToUsersTests < ActiveRecord::Migration[6.1]
  def change
    add_column :users_tests, :successfully, :boolean
    add_column :users_tests, :result, :integer

    UsersTest.all.each do |user_test|
      user_test.result = user_test.result_in_persent
      user_test.successfully = user_test.result >= UsersTest::MIN_PERCENT_SUCCESS_PASSED_TEST
      
      user_test.save!
    end
  end
end
