class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :ban, :unban]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:ban, :unban]

  def index
    @users = User.order(:name).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to Autorulate!"
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
  end

  def ban
    User.find(params[:id]).update(banned: true)
    flash[:success] = "User banned!"
    redirect_to users_url
  end

  def unban
    User.find(params[:id]).update(banned: false)
    flash[:success] = "User unbanned!"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
