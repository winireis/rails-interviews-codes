class UsersController < ApplicationController
  def index
    if params[:q]
      @users = User.find(params[:q])
    else
      @users = nil
    end
  end

  def show
  end
end
