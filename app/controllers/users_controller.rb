class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  
  def new	
  end

  def show
    @user = User.find(params[:id])
    @secrets = @user.secrets
    @secrets_liked = @user.secrets.group(:id).order(:id)
  end

   def create
    @user = User.new user_params
    if @user.save
      redirect_to "/users/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      
    # if @user.update_attribute(:name, params[:user][:name])
       # @user.update_attribute(:email, params[:user][:email])
      flash[:success] = "User successfully updated"
      redirect_to "/users/"+params[:id]
   
    else
      flash[:errors] = @user.errors.full_messages
       redirect_to "/users/#{params[:id]}/edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to '/sessions/new'
  end


  private
	def user_params
    params[:user].delete(:password) if params[:user][:password].blank?    
	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

  # def update_params
  #   params.require(:user).permit(:name, :email)
  # end
end
