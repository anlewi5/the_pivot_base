require 'rails_helper'

RSpec.describe 'As a visitor' do
	describe 'when visiting an items show page' do
		it 'a user cannot see add to cart for a retired item' do
			category = create(:category)
			item_one = create(:item, category: category, condition: 'retired')

			visit item_path(item_one)

			expect(page).not_to have_content("Add to cart")
		end
	end
end
