class UsersController < ApplicationController
 before_action :ensure_current_user, {only: [:edit, :update]}

 def show
  @book = Book.new
  @user = User.find(params[:id])
  @userebook = @user.books

 end

 def index
  @book = Book.new
  @user = current_user
  @users = User.all
 end

 def edit
  @user = User.find(params[:id])
  if @user == current_user
   render "edit"
  else
   redirect_to user_path(current_user)
  end
 end

 def create
  @user = User.new(@user_params)
  @user.user_id = current_user.id
  @user.save
  redirect_to user_path(@user.id)
 end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
   flash[:update] = 'You have updated user successfully.'
     redirect_to user_path(@user.id)
  else
      render "edit"
  end
 end

  private
  def user_params
   params.require(:user).permit(:name, :title, :profile_image, :introduction)
  end


  def ensure_current_user
    if current_user.id != params[:id].to_i
      flash[:notice]=""
      redirect_to user_path(current_user)
    end
  end
end
