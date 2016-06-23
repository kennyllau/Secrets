class SecretsController < ApplicationController
	before_action :require_login, only: [:index, :create, :destroy]

	def index
		@secrets = Secret.all
	end

	def create
	
		# secret = Secret.new(content: secret_params['content'], user: current_user)
		Secret.create(content: params[:secret][:content], user: current_user)
		redirect_to "/users/#{current_user.id}"
	end

  	def destroy
	    secret = Secret.find(params[:id])
	    secret.destroy if secret.user == current_user
	    redirect_to "/users/#{current_user.id}"
  	end
	
end