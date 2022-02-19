class PostsController < ApplicationController
  def index
    render json: { posts: PostBlueprint.render_as_json(Post.all.to_a) }
  end
end
