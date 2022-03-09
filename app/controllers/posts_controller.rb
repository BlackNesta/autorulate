class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def show
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_path(current_user)
    else
      #to change it
      render 'static_pages/home'
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

    def post_params
      params.require(:post).permit(:title, :content)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
