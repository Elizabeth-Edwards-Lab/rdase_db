https://guides.rubyonrails.org/testing.html


C: Unit Test for Controller 
M: There are also unit test for model (for the purpose of test the self-defined methods, validations, associations, scopes, etc. )
V: Unit test for helper (helper is for reduce the logic expose in view)

Your tests are run under RAILS_ENV=test (if you test on server)

We can run all of our tests at once by using the `rails test` command.
You can also run a particular test method from the test case by providing the -n or --name flag and the test's method name.
e.g. `rails test test/models/article_test.rb -n test_the_truth`


# Parallel Testing
Parallel Testing => run test with multiple threads
modify the code in test_helper.rb
```
class ActiveSupport::TestCase
  parallelize(workers: 2)
end
```

# System tests
System tests allow you to test user interactions with your application, running tests in either a real or a headless browser. System tests use Capybara under the hood.
generate system test case by `rails generate system_test users`
 
all you need to code sth like this in the system_test file
```
require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit users_url
      assert_selector "h1", text: "Users"
  end
end
```