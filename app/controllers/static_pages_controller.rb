class StaticPagesController < ApplicationController
  def home
    @feed_items = Post.paginate(page: params[:page])
    @body_type = ["Cabrio", "Combi", "Compact", "Coupe", "Sedan", "SUV", "Small car", "Minivan"]
    @gearbox_type = ["Manual", "Automatic"]
    @transmition_type = ["Front", "Rear", "4x4"]
    @fuel_type = ["Petrol", "Diesel", "GPL", "Petrol + GPL", "Electric", "Hybrid"]
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
