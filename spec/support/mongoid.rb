RSpec.configure do |config|
  # Clean MongoDB
  config.before :each do
    Mongoid.purge!
  end
end
