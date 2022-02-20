require "rails_helper"

RSpec.describe "/users" do
  before do
    User.create!(
      email: "user@example.org", first_name: "John", last_name: "Smith"
    )
  end

  it "lists all users" do
    get "/users"

    expect(response.parsed_body).to match(
      "users" => [
        {
          "id" => be_an(Integer),
          "email" => "user@example.org",
          "fullName" => "John Smith"
        }
      ]
    )
  end
end
