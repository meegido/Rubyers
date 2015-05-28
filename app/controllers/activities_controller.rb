class ActivitiesController < ApplicationController
	before_action :authenticate_user!, only: [:index]

	def index
		@users = current_user.active_friends
		# @users.push(current_user) esta linea permite que el current user aparezca en el timeline como un user mas
		case params[:content] when 'posts'
			@activities = PublicActivity::Activity.where(owner_id: @users, trackable_type: "Post").order('created_at DESC')
		else
			@activities = PublicActivity::Activity.where(owner_id: @users).order('created_at DESC')
		end
	end

end