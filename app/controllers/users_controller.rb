class UsersController < ApplicationController
  def index
    @users = User.includes([ :profile, :followees ]).where.not(id: current_user.id)
  end

  def show
    @user = User.includes([ :profile, :followees ]).find(params[:id])
  end
end
