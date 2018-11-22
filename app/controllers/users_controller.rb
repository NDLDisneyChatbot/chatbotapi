class UsersController < ApplicationController
	before_action :set_user, only: [:show, :update]
	
	def index
		@users = User.all
		render json: @users, status: :ok
	end

	def create
		@user = User.create!(user_params)
		res = Faraday.get "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=HackPSU2018&q=#{@user.latitude}%2C#{@user.longitude}"
		res = JSON res.body
		puts res
		puts res['Key']
		render json: {user: @user, locationKey: res['Key'] }, status: :ok
	end
	def update
		@user.status = user_params[:status]
		@user.latitude = user_params[:latitude]
		@user.longitude = user_params[:longitude]
		puts @user
		@user.save!
		render json: @user, status: :ok
	end
	def show
		render json: @user, status: :ok
	end
	def message
		puts message_params
		res = Faraday.get 'http://localhost:3010/api/users/chatMessage', message_params
		render json: res, status: :ok
	end

	def pickup
		@users = User.all
		par = '['
		@users.each do |user|
			par += "[#{user.latitude},#{user.longitude},#{user.status}],"
		end
		par = par[0...-1] 
	        par += ']'
		output = `python3 ./cluster.py #{par}`
		render json: output, status: :ok
	end
	private

	def user_params
		params.require(:name)
		params.require(:latitude)
		params.require(:longitude)
		params.require(:status)
		params.permit(:name, :mobile, :longitude, :latitude, :status)
	end
	def set_user
		@user = User.find_by name: params[:name]
	end
	def message_params
		params.permit(:locationKey, :message)
	end
end
