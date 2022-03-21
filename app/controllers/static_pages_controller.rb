class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = Post.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def favorites
    @favorites = (current_user.favorites || [] ).paginate(page: params[:page])
  end
end
