require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# spec/supportの下読み込み
Dir[Rails.root.join('spec/support/config/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/helper/*.rb')].each { |f| require f }

# Capybara設定
Capybara.server = :puma, { Silent: true }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # FactoryBotのメソッド使う
  # config.include FactoryBot::Syntax::Methods

  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
