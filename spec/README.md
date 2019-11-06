# List of test you can run:







# RSpec also provides its own spec file generators
```
rails generate rspec:model user
      create  spec/models/user_spec.rb
```

# reference of Rspec
Default: Run all spec files (i.e., those matching spec/\*\*/\*_spec.rb)
` bundle exec rspec`
Run all spec files in a single directory (recursively)
`bundle exec rspec spec/models`
Run a single spec file
`bundle exec rspec spec/controllers/accounts_controller_spec.rb`
Run a single example from a spec file (by line number)
`bundle exec rspec spec/controllers/accounts_controller_spec.rb:8`
See all options for running specs
`bundle exec rspec --help`