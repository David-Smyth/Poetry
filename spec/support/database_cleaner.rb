RSpec.configure do |config|

  # Before entire test suite runs, clear the test database completely.
  # This gets rid of any garbage left over from interrupted or poorly
  # written tests -- a common source for surprising behavior.
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # Set default database cleaning strategy to be transactions.
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # Only runs before examples that have been flagged with :js => true.
  # By default, this is only true for tests where Capybara fires up a
  # test server process and drives and actual browser window fia the
  # Selenium backend. For these types of tests, transactions won't
  # work because the entire test is _not_ run within the RSpec process.
  # So this overrides the above :transaction strategy, and uses the
  # :truncation strategy instead.
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  # The following two configurations hook up database_cleaner around
  # the beginning and end of each test, telling it to execute whatever
  # cleanup strategy we selected above.
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end