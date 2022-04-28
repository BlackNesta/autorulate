class StaticPagesController < ApplicationController
  def home
    @feed_items = Post.paginate(page: params[:page])
    @brand =  ["Volkswagen", "Mercedes-benz", "Bmw", "Audi", "Ford", "Skoda", "Opel", "Renault", "Dacia", "Toyota", "Mazda", "Peugeot", "Hyundai", "Volvo", "Porsche", "Land rover", "Nissan", "Fiat", "Seat", "Citroen", "Kia", "Mitsubishi", "Jaguar", "Suzuki", "Lexus", "Jeep", "Honda", "Mini", "Chevrolet", "Subaru", "Alfa romeo", "Infiniti", "Smart", "Bentley", "Dodge", "Daewoo", "Saab", "Rover", "Isuzu", "Ssangyong", "Hummer", "Maserati", "Chrysler", "Rolls-royce"] 
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
