class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "You are successfully registered and logged in!"
      redirect_to "/profile"
    else
      flash[:notice] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :city, :state, :zip, :email, :password)
  end
end