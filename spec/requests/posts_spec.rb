require "rails_helper"

RSpec.describe "/posts" do
  before do
    Post.create!(
      title: "Docker done right", body: "For development purposes only"
    )
  end

  it "lists all posts" do
    get "/posts"

    expect(response.parsed_body).to match(
      "posts" => [
        {
          "id" => be_a(String),
          "title" => "Docker done right",
          "body" => "For development purposes only"
        }
      ]
    )
  end
end
