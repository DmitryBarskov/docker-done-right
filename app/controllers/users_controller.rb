class UsersController < ApplicationController
  def index
    render json: { users: UserBlueprint.render_as_json(User.all) }
  end
end
