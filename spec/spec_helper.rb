require "factory_bot"
require "active_support/core_ext/array/access"
require_relative "./support/shared"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end
