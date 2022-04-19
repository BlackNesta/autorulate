class PriceModel < Eps::Base

  def build
    cars = []
    dataset = File.open("app/ml_models/cars_dataset.csv")
    dataset.readlines.each do |d|
      car = d.split(",")
      cars << {
        brand: car[0],
        model: car[1],
        year: car[2].to_i,
        mileage: car[3].to_i,
        fuel: car[4],
        power: car[5].to_i,
        cc: car[6].to_i,
        transmition: car[7],
        gearbox: car[8],
        body: car[10],
        price: car[11].strip.to_i
      }
    end

    #train
    model = Eps::Model.new(cars, target: :price, algorithm: :linear_regression)
    puts model.summary

    File.write(model_file, model.to_pmml)

    # ensure reloads from file
    @model = nil

  end

  def predict(car)
    model.predict(features(car)).to_i
  end

  private

  def features(car)
    {
      brand: car[:brand],
      model: car[:model],
      year: car[:year].to_i,
      mileage: car[:mileage].to_i,
      fuel: car[:fuel],
      power: car[:power].to_i,
      cc: car[:cc].to_i,
      transmition: car[:transmition],
      gearbox: car[:gearbox],
      body: car[:body],
      price: car[:price].to_i
    }
  end
  
  def model
    @model ||= Eps::Model.load_pmml(File.read(model_file))
  end

  def model_file
    File.join(__dir__, "price_model.pmml")
  end

end
