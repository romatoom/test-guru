class AddSuccessfullyToUsersTests < ActiveRecord::Migration[6.1]
  def change
    add_column :users_tests, :successfully, :boolean

    UsersTest.all.each do |user_test|
      user_test.successfully = user_test.result_in_persent >= UsersTest::MIN_PERCENT_SUCCESS_PASSED_TEST
      user_test.save!
    end
  end
end
