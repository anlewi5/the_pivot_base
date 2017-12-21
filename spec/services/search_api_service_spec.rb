require 'rails_helper'

RSpec.describe SearchApiService do
  describe "existence" do
    it "initializes with attributes type and search word as 'q'" do
      attrs = {'type': 'items', 'q': 'book'}
      search_api_service = SearchApiService.new(attrs)
      expect(search_api_service).to be_a SearchApiService
    end

    it "can initialize without a search word" do
      attrs = {'type': 'store'}
      search_api_service = SearchApiService.new(attrs)
      expect(search_api_service).to be_a SearchApiService
    end
  end

  describe "#instance_methods" do
    describe "#search" do
      context "returns objects that are of the specific type without a search word" do
        it "returns all items when type is items" do
          create_list(:item, 2)
          attrs = {'type': 'items'}
          search_api_service = SearchApiService.new(attrs)

          item_results = search_api_service.search
          item = item_results.first

          expect(item).to be_a Item
          expect(item_results.count).to eq 2
        end

        it "returns all stores when type is store" do
          create_list(:store, 3)
          attrs = {'type': 'store'}
          search_api_service = SearchApiService.new(attrs)

          store_results = search_api_service.search
          store = store_results.first

          expect(store).to be_a Store
          expect(store_results.count).to eq 3
        end

        it "returns all users when type is users" do
          create_list(:user, 2)
          attrs = {'type': 'users'}
          search_api_service = SearchApiService.new(attrs)

          user_results = search_api_service.search
          user = user_results.first

          expect(user).to be_a User
          expect(user_results.count).to eq 2
        end

        it "returns all categories when type is category" do
          create_list(:category, 3)
          attrs = {'type': 'category'}
          search_api_service = SearchApiService.new(attrs)

          category_results = search_api_service.search
          category = category_results.first

          expect(category).to be_a Category
          expect(category_results.count).to eq 3
        end

      end

      context "returns objects of the type that have an attribute with the specified search word or query" do
        context "items are searchable by title or description" do
          it "returns all items that have a book in either the title or description with 'q=book'" do
            item_1 = create(:item, title: 'Book weight')
            item_2 = create(:item, title: 'basketball')
            item_3 = create(:item, description: "A booklover's dream")
            attrs = {'type': 'items', 'q': 'book'}
            search_api_service = SearchApiService.new(attrs)

            item_results = search_api_service.search

            expect(item_results.count).to eq 2
            expect(item_results).to include(item_1)
            expect(item_results).to include(item_3)
            expect(item_results).to_not include(item_2)
          end
        end

        context "stores are searchable by name" do
          it "returns all stores that have 'hat' in the name 'q=hat'" do
            store_1 = create(:store, name: 'Tinlid Hats')
            store_2 = create(:store, name: 'Wood Chopping Emporium')
            attrs = {'type': 'stores', 'q': 'hat'}
            search_api_service = SearchApiService.new(attrs)

            store_results = search_api_service.search

            expect(store_results.count).to eq 1
            expect(store_results).to include(store_1)
            expect(store_results).to_not include(store_2)
          end
        end

        context "users are searchable by first_name or last_name" do
          it "returns all users that have 'Jess' in first_name or last_name 'q=jess'" do
            user_1 = create(:user, first_name: 'Katie', last_name: 'Chambiers')
            user_2 = create(:user, first_name: 'Jessica', last_name: 'Downton')
            user_3 = create(:user, first_name: 'Blanca', last_name: 'Ajessup')
            attrs = {'type': 'user', 'q': 'jess'}
            search_api_service = SearchApiService.new(attrs)

            user_results = search_api_service.search

            expect(user_results.count).to eq 2
            expect(user_results).to include(user_2)
            expect(user_results).to include(user_3)
            expect(user_results).to_not include(user_1)
          end
        end

        context "categories are searchable by title" do
          it "returns all categories that have 'suspense' the title 'q=SuSpEnSe'" do
            category_1 = create(:category, title: 'Memoir')
            category_2 = create(:category, title: 'Suspense')
            attrs = {'type': 'categories', 'q': 'SuSpEnSe'}
            search_api_service = SearchApiService.new(attrs)

            category_results = search_api_service.search

            expect(category_results.count).to eq 1
            expect(category_results).to include(category_2)
            expect(category_results).to_not include(category_1)
          end
        end
      end
    end
  end
end
