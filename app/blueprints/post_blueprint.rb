class PostBlueprint < Blueprinter::Base
  identifier :id do |post|
    post.id.to_s
  end

  fields :title, :body
end
