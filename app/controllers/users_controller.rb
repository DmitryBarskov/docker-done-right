class UsersController < ApplicationController
  def index
    render json: { users: UserBlueprint.render(User.all) }
  end
end
