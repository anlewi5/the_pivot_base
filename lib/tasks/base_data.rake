desc "Load Base Data per Project Specs"
task load_base_data: :environment do

  randomizer = Random.new

  #Make sure each role is present in database and assign it to a variable for readability
  role_1 = Role.find_or_create_by(name: "Registered User")
  role_2 = Role.find_or_create_by(name: "Store Manager")
  role_3 = Role.find_or_create_by(name: "Store Admin")
  role_4 = Role.find_or_create_by(name: "Platform Admin")
  puts "#{Role.count} Roles in database. There should be 4"

  #Create 11 users, 3 of them being Josh, Ian, and Cory.
  user_count_before = User.count
  user_1 = User.create(first_name: "Josh", last_name: "Mejia", email: "josh@turing.io", password: "password", address: "1331 17th St")
  user_2 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_3 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_4 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_5 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_6 = User.create(first_name: "Ian", last_name: "Douglas", email: "ian@turing.io", password: "password", address: "1331 17th St")
  user_7 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_8 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_9 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_10 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", address: Faker::Address.street_address)
  user_11 = User.create(first_name: "Cory", last_name: "Westerfield", email: "cory@turing.io", password: "password", address: "1331 17th St")
  puts "#{User.count - user_count_before} New Users Created! This should be 11 the first time."

  #Stores are inspired by existing faker gems that'll allow for easier 'realistic' item creation.
  store_count_before = Store.count
  store_1 = Store.find_or_create_by(name: "Silicon Valley Knockoffs", status: 1)
  store_2 = Store.find_or_create_by(name: "PokeStore", status: 1)
  store_3 = Store.find_or_create_by(name: "Healthy Drinks", status: 1)
  store_4 = Store.find_or_create_by(name: "Super Power Shop", status: 1)
  store_5 = Store.find_or_create_by(name: "Much Sounds", status: 1)
  puts "#{Store.count - store_count_before} New Stores Created! This should be 5 the first time."


  userrole_count_before = UserRole.count
  #Each user is atleast a registered user, role_1.
  UserRole.find_or_create_by(user: user_1, role: role_1)
  UserRole.find_or_create_by(user: user_2, role: role_1)
  UserRole.find_or_create_by(user: user_3, role: role_1)
  UserRole.find_or_create_by(user: user_4, role: role_1)
  UserRole.find_or_create_by(user: user_5, role: role_1)
  UserRole.find_or_create_by(user: user_6, role: role_1)
  UserRole.find_or_create_by(user: user_7, role: role_1)
  UserRole.find_or_create_by(user: user_8, role: role_1)
  UserRole.find_or_create_by(user: user_9, role: role_1)
  UserRole.find_or_create_by(user: user_10, role: role_1)
  UserRole.find_or_create_by(user: user_11, role: role_1)

  #Josh, user_1, is a store manager, role_2, for 5 new stores.
  UserRole.find_or_create_by(user: user_1, role: role_2, store: store_1)
  UserRole.find_or_create_by(user: user_1, role: role_2, store: store_2)
  UserRole.find_or_create_by(user: user_1, role: role_2, store: store_3)
  UserRole.find_or_create_by(user: user_1, role: role_2, store: store_4)
  UserRole.find_or_create_by(user: user_1, role: role_2, store: store_5)

  #There are 5 store admins, role_3, one being Ian, user_6. Other users are user_7 through _10.
  UserRole.find_or_create_by(user: user_6, role: role_3, store: store_1)
  UserRole.find_or_create_by(user: user_7, role: role_3, store: store_2)
  UserRole.find_or_create_by(user: user_8, role: role_3, store: store_3)
  UserRole.find_or_create_by(user: user_9, role: role_3, store: store_4)
  UserRole.find_or_create_by(user: user_10, role: role_3, store: store_5)

  #There's one platform admin, role_4, Cory
  UserRole.find_or_create_by(user: user_11, role: role_4)
  puts "#{UserRole.count - userrole_count_before} UserRoles Created! (This should be 22 the first time.)"

  #Create 10 Unique categories
  category_count_before = Category.count
  categories = []
  10.times { categories << Category.find_or_create_by(title: Faker::Hipster.unique.word) }
  puts "#{Category.count - category_count_before} Categories Created! (This should always be 10)"

  #Create 5 items per each of the 10 new categories and assign them to a store
  #with a relevant but random item title along with random description, price.
  #Also, shovel items into items array.
  item_count_before = Item.count
  items = []
  categories.each do |category|
    items << category.items.create(store: store_1, description: Faker::Hipster.sentence, price: randomizer.rand(2.00..100.00).round(2), title: Faker::SiliconValley.unique.invention, image: File.new("#{Rails.root}/app/assets/images/five_stores/silicon_valley.jpeg", "r"))
    items << category.items.create(store: store_2, description: Faker::Hipster.sentence, price: randomizer.rand(2.00..100.00).round(2), title: Faker::Pokemon.unique.move, image: File.new("#{Rails.root}/app/assets/images/five_stores/pokestore.jpeg", "r"))
    items << category.items.create(store: store_3, description: Faker::Hipster.sentence, price: randomizer.rand(2.00..100.00).round(2), title: Faker::Beer.unique.name, image: File.new("#{Rails.root}/app/assets/images/five_stores/drink.jpeg", "r"))
    items << category.items.create(store: store_4, description: Faker::Hipster.sentence, price: randomizer.rand(2.00..100.00).round(2), title: Faker::Superhero.unique.power, image: File.new("#{Rails.root}/app/assets/images/five_stores/POW.jpeg", "r"))
    items << category.items.create(store: store_5, description: Faker::Hipster.sentence, price: randomizer.rand(2.00..100.00).round(2), title: Faker::Music.unique.instrument, image: File.new("#{Rails.root}/app/assets/images/five_stores/much_sounds.jpeg", "r"))
  end
  puts "#{Item.count - item_count_before} Items Created! (This should 50 the first time.)"

  #Randomly create anywhere between 1 and 5 orders for each of the first 5 registered users.
  #Each order will be created from a randomly constructed cart with items chosen randomly across all stores (potentially creating multiple orders).
  order_count_before = Order.count
  orderitem_count_before = OrderItem.count
  users = [user_1, user_2, user_3, user_4, user_5]
  users.each do |user|
    cart = {}
    randomizer.rand(1..9).times { cart[items.sample] = randomizer.rand(1..4) }
    OrderCreationService.create_from_cart(cart, user)
  end
  puts "#{Order.count - order_count_before} Orders created! (This should be random)"
  puts "#{OrderItem.count - orderitem_count_before} OrderItems created! (This should be random)"

end
