class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user_by_id, :check_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy User.all, items: Settings.item_per_page
  end

  def new
    @user = User.new
  end

  def show
    @pagy, @microposts = pagy @user.feed, items: Settings.item_per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_active_mail
      flash[:info] = t "check_mail"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "user_delete_fail"
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email,
                                 :password,
                                 :password_confirmation)
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def check_user
    return if @user&.activated

    flash[:danger] = t "user_not_activated"
    redirect_to root_url
  end
end
