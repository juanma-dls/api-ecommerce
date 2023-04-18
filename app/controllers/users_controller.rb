class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_users, only: [:show, :destroy]

    #GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  #GET /users/:id
  def show
      render json: @user, status: :ok
  end

  #DELETE /users/:id
  def destroy
      if @user.destroy
        render json: {
          status: { message: 'User deleted successfully, the session has been closed'}
        }, status: 200
      else
        ender json: {
          status: { message: 'User could not be deleted successfully', errors: @user.errors.full_messages}
        }, status: :unprocessable_entity
      end
  end

  private

  def set_users
    @user = User.find_by_id(params[:id])
  end

end
