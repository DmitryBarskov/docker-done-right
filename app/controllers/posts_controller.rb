class PostsController < ApplicationController
  def index
    render json: { posts: PostBlueprint.render(Post.all) }
  end
end
