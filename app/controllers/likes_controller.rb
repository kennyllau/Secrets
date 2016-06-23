class LikesController < ApplicationController
  before_action :require_login
  # before_action :require_correct_user_likes, only: [:destroy, :create]

  def create

  	secret = Secret.find(params[:secret_id])
  	like = Like.create(user: current_user, secret: secret)
  	redirect_to '/secrets' 
  end

  def destroy
  	# Like.all.where(user: User.find(session[:user_id]),secret: Secret.find(params[:secret_id])).destroy_all
  	like = Like.find(params[:id])
    if like.user == current_user
      like.destroy
  	  redirect_to '/secrets'
    else
      redirect_to '/sessions/new'
    end  
  end

end