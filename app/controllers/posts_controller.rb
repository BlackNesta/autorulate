class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  before_action :load_post, only: [:show, :edit, :update]
  before_action :load_post_fields, only: [:new, :edit, :filter]
  
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

  def filter
    @feed_items = Post.all
    filter = params[:specs]
    @feed_items = @feed_items.where(brand: filter[:brand].capitalize) if filter[:brand].present?
    @feed_items = @feed_items.where(model: filter[:model].capitalize) if filter[:model].present?
    @feed_items = @feed_items.where(fuel: filter[:fuel]) if filter[:fuel].present?
    @feed_items = @feed_items.where(transmition: filter[:transmition]) if filter[:transmition].present?
    @feed_items = @feed_items.where(gearbox: filter[:gearbox]) if filter[:gearbox].present?
    @feed_items = @feed_items.where(body: filter[:body]) if filter[:body].present?
    @feed_items = @feed_items.where('year >= ?', filter[:min_year]) if filter[:min_year].present?
    @feed_items = @feed_items.where('year <= ?', filter[:max_year]) if filter[:max_year].present?
    @feed_items = @feed_items.where('cc >= ?', filter[:min_cc]) if filter[:min_cc].present?
    @feed_items = @feed_items.where('cc <= ?', filter[:max_cc]) if filter[:max_cc].present?
    @feed_items = @feed_items.where('power >= ?', filter[:min_horsepower])  if filter[:min_horsepower].present?
    @feed_items = @feed_items.where('power <= ?', filter[:max_horsepower])  if filter[:max_horsepower].present?
    @feed_items = @feed_items.where('mileage >= ?', filter[:min_km])  if filter[:min_km].present?
    @feed_items = @feed_items.where('mileage <= ?', filter[:max_km])  if filter[:max_km].present?
    @feed_items = @feed_items.where('price >= ?', filter[:min_price])  if filter[:min_price].present?
    @feed_items = @feed_items.where('price <= ?', filter[:max_price])  if filter[:max_price].present?
    @feed_items = @feed_items.paginate(page: params[:page])
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
      @brand =  ["Volkswagen", "Mercedes-benz", "Bmw", "Audi", "Ford", "Skoda", "Opel", "Renault", "Dacia", "Toyota", "Mazda", "Peugeot", "Hyundai", "Volvo", "Porsche", "Land rover", "Nissan", "Fiat", "Seat", "Citroen", "Kia", "Mitsubishi", "Jaguar", "Suzuki", "Lexus", "Jeep", "Honda", "Mini", "Chevrolet", "Subaru", "Alfa romeo", "Infiniti", "Smart", "Bentley", "Dodge", "Daewoo", "Saab", "Rover", "Isuzu", "Ssangyong", "Hummer", "Maserati", "Chrysler", "Rolls-royce"] 
      @model = {:"Mercedes-benz"=>["Gls", "Gle", "S", "Glc", "C", "E", "Amg", "Glk", "B", "Cls", "A", "Cla", "Glc coupe", "V", "Gle coupe", "X", "Viano", "Vito", "Clk", "Gla", "Ml", "G", "Sprinter", "Slc", "Glb", "Sl", "Slk", "Citan"], :Ford=>["F150", "Ecosport", "Focus", "Fiesta", "C-max", "Galaxy", "Kuga", "Mustang", "S-max", "Mondeo", "Ranger", "Ka", "Tourneo custom ", "Transit", "Focus c-max", "Transit connect", "Puma", "Tourneo connect", "Explorer", "Fusion", "Grand c-max", "Edge", "Transit custom ", "Tourneo", "Bronco"], :Bmw=>["X6 m", "Seria 5", "Seria 3", "X5", "Seria 2 ", "X4", "X6", "Seria 7", "Seria 4", "X1", "X3", "Seria 8", "Seria 1", "X5 m", "X2", "Z4", "M5", "Seria 6", "X7", "X4 m", "I3", "M4"], :Peugeot=>["3008", "207", "Boxer", "2008", "308", "307", "206", "4007", "208", "Altul", "508", "Partner", "407", "5008"], :Audi=>["A6", "A4", "A3", "Q5", "A8", "A1", "Q3", "A5", "A7", "Rs7", "Q7", "Q8", "A6 allroad", "S3", "Sq7", "Sq5", "S5", "Tt", "Sq8"], :Volkswagen=>["Golf", "Polo", "Passat", "Tiguan", "Caddy", "Multivan", "Passat alltrack", "Touran", "Touareg", "Sharan", "Golf plus", "Scirocco", "T-roc", "Passat cc", "Transporter", "Bora", "Phaeton", "Crafter", "Caravelle", "Arteon", "Golf sportsvan", "Jetta", "Amarok", "T-cross", "Eos", "Beetle"], :Opel=>["Astra", "Antara", "Meriva", "Insignia", "Corsa", "Vivaro", "Mokka", "Zafira", "Grandland x", "Tigra", "Adam", "Crossland", "Vectra", "Signum", "Ampera", "Combo", "Agila"], :Dacia=>["Logan", "Duster", "Sandero", "Dokker", "Logan stepway", "Lodgy", "Sandero stepway", "Logan van", "Pick-up"], :Skoda=>["Octavia", "Yeti", "Superb", "Scala", "Citigo", "Roomster", "Rapid", "Kodiaq", "Fabia", "Karoq", "Kamiq", "100"], :Hyundai=>["Tucson", "I40", "Santa fe", "Elantra", "I20", "Ix35", "I30", "Altul", "Kona", "I10", "Grand santa fe"], :Renault=>["Clio", "Kadjar", "Megane", "Kangoo", "Scenic", "Trafic", "Fluence", "Laguna", "Koleos", "Talisman", "Grand scenic", "Twingo", "Captur", "Symbol", "Master", "Espace"], :Porsche=>["Macan", "Cayenne", "911", "Boxster", "Panamera"], :Mini=>["Countryman", "One", "Cooper", "Cooper s"], :Volvo=>["Xc 60", "Xc 90", "V40", "S80", "Xc 70", "S60", "V60", "S40", "V50", "S90", "Xc 40"], :"Land rover"=>["Range rover sport", "Range rover evoque", "Defender", "Range rover velar", "Discovery sport", "Range rover", "Freelander", "Discovery"], :Suzuki=>["Alto", "Grand vitara", "Swift", "Ignis", "Jimny", "Across", "Vitara", "Sx4", "Sx4 s-cross"], :Fiat=>["Croma", "Grande punto", "Tipo", "Panda", "500", "Punto", "Doblo", "Ducato", "Sedici", "500x", "Bravo", "Freemont"], :Dodge=>["Challenger", "Avenger"], :Mazda=>["Cx-5", "6", "5", "3", "Cx-7", "Cx-30", "2", "Cx-3", "323", "Mx-5"], :Mitsubishi=>["Pajero", "L200", "Outlander", "Colt", "Lancer", "Asx", "Grandis", "Pajero pinin"], :Infiniti=>["Q70", "Q30", "Q50", "Qx70", "Fx 35"], :Citroen=>["C4", "Spacetourer", "C-elysee", "C5", "C3 aircross", "C4 grand picasso", "Ds4", "C4 cactus", "C3", "Xsara", "C4 picasso", "C8", "Xsara picasso", "C1", "Berlingo", "Ds3", "C-crosser"], :Kia=>["Cerato", "Sportage", "Sorento", "Picanto", "Ceed", "Soul", "Xceed"], :Honda=>["Jazz", "Cr-v", "Hr-v", "Prelude", "Civic", "Accord", "Fr-v"], :Seat=>["Leon", "Ibiza", "Exeo", "Alhambra", "Tarraco", "Altea", "Mii", "Ateca", "Toledo", "Cordoba", "Arona"], :Nissan=>["Micra", "Qashqai", "X-trail", "Navara", "Juke", "Patrol", "Np300 pickup", "Pulsar", "Qashqai+2", "Altul", "Note"], :Chevrolet=>["Camaro", "Matiz", "Captiva", "Cruze", "Aveo", "Nubira", "Epica"], :Toyota=>["Auris", "Hilux", "Prius", "Yaris", "Rav4", "Camry", "Corolla", "Avensis", "C-hr", "Aygo", "Land cruiser", "Proace", "Tundra", "Corolla verso"], :Chrysler=>["Grand voyager"], :Jaguar=>["Xf", "F-pace", "Xe", "Xj", "E-pace"], :Lexus=>["Seria is", "Seria lx", "Seria nx", "Seria rx", "Altul", "Ux", "Lc 500"], :Smart=>["Forfour", "Fortwo"], :Subaru=>["Forester", "B9 tribeca"], :Jeep=>["Compass", "Renegade", "Grand cherokee", "Wrangler", "Cherokee"], :"Alfa romeo"=>["Giulietta", "159", "Stelvio", "Giulia"], :Daewoo=>["Matiz"], :"Rolls-royce"=>["Wraith"], :Bentley=>["Bentayga", "Continental"], :Rover=>["75"], :Isuzu=>["D-max"], :Ssangyong=>["Tivoli"], :Hummer=>["H2"], :Maserati=>["Quattroporte"], :Saab=>["9-3"]} 
      gon.model = @model
      @body_type = ["Cabrio", "Combi", "Compact", "Coupe", "Sedan", "SUV", "Small car", "Minivan"]
      @gearbox_type = ["Manual", "Automatic"]
      @transmition_type = ["Front", "Rear", "4x4"]
      @fuel_type = ["Petrol", "Diesel", "GPL", "Petrol + GPL", "Electric", "Hybrid"]
    end

end
