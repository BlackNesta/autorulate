# Create a main sample user.
User.create!(name: "ADMIN",
  email: "admin@autorulate.herokuapp.com",
  password: "admin123",
  password_confirmation: "admin123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)
# Generate a bunch of additional users.
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.all
cars = File.open("app/ml_models/cars_dataset.csv")
cars.readlines.each do |c|
  car = c.split(",")
  post = {
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
  post[:title] = car[0] + " " + car[1]
  post[:location] = Faker::Address.city
  users.sample.posts.create!(post)
end