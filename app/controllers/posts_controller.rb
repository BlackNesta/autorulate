class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :load_post, only: [:show, :edit, :update]
  before_action :load_post_fields, only: [:new, :edit]
  
  def show
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.images.attach(params[:post][:images].values) if params[:post][:images].present?
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_path(current_user)
    else
      #@feed_items = Post.paginate(page: params[:page])
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    if request.referrer.nil? || request.referrer == posts_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  def edit
  end

  def update
    @post.update(post_params)
    @post.images.attach(params[:post][:images].values) if params[:post][:images].present?
    redirect_to @post
  end

  def add_to_favorites
    UserFavoriteCar.create(user_id: current_user.id, post_id: params[:id])
  end

  def remove_from_favorites
    UserFavoriteCar.find_by(post_id: params[:id]).destroy
  end

  def predict_price
    binding.pry
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :images, :location, :body, :brand, :model, :year, :price, :mileage, :fuel, :power, :transmition, :gearbox, :cc)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    def load_post
      @post = Post.find(params[:id])
    end

    def load_post_fields
      @body_type = ["Cabrio", "Combi", "Compact", "Coupe", "Sedan", "SUV", "Small car", "Minivan"]
      @gearbox_type = ["Manual", "Automatic"]
      @transmition_type = ["Front", "Rear", "4x4"]
      @fuel_type = ["Petrol", "Diesel", "GPL", "Petrol + GPL", "Electric", "Hybrid"]
    end

end
