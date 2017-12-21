namespace :add_store_to_items do
  desc "Creates initial store"
  task create_initial_store: :environment do
    if Store.find_by(name: "Little Shop of Funsies")
      puts "Store already exists"
    else
      store = Store.create(name: "Little Shop of Funsies", status: "active")
      puts "#{store.name} created"
    end
  end

  desc "Adds store to items 1-1011 which are the items in the original store"
  task associate_items: :environment do
    items = Item.where(id: 1..1011)
    store = Store.find_by(name: "Little Shop of Funsies")

    items.each do |item|
      if item.store
        puts "#{item.title} already has a store."
      else
        store.items << item
        puts "#{store.name} now has #{store.items.count} items."
      end
    end
  end
end
