class PostsController < ApplicationController

	before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		 if params[:tag]
		    @posts = Post.tagged_with(params[:tag])
		  else
		    @posts = Post.all.order("created_at DESC")
		  end		
		
	end

	def show
		@comments = Comment.where(post_id: @post)
		@random_post = Post.where.not(id: @post).order("RANDOM()").first
		@random_post_2 = Post.where.not(id: @post).order("RANDOM()").last

	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			@post.create_activity key: 'post.created', owner: @post.user
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	def upvote
		@post.upvote_by current_user
		redirect_to :back
	end

	def downvote
		@post.downvote_from current_user
		redirect_to :back
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :link, :description, :image, :tag_list, directions_attributes: [:id, :step, :gist, :place, :_destroy])
	end
end
