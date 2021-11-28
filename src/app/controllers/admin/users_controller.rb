class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    return redirect_to admin_user_url(@user), success: 'アカウントを作成しました！' if @user.save

    render :new
  end

  def show; end

  def edit; end

  def update
    return redirect_to admin_user_url(@user), success: "ユーザー「#{@user.name}」を更新しました！" if @user.update user_params

    render :edit
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, danger: "ユーザー「#{@user.name}」を削除しました!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find params[:id]
  end

  def require_admin
    redirect_to root_url unless current_user.admin?
  end
end
