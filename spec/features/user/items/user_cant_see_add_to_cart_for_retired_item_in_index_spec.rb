require 'rails_helper'

RSpec.describe 'As a visitor' do
	describe 'when visiting an items show page' do
		it 'a user cannot see add to cart for a retired item' do
			category = create(:category)
			one_url = "http://pandathings.com/wp-content/uploads/2016/10/onesie-6-300x300.png"
			item_one = create(:item, category: category, condition: 'retired')

			visit items_path

			expect(page).not_to have_content("Add to cart")
		end
	end
end
