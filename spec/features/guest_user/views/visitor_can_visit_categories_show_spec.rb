require 'rails_helper'

describe "As a visitor I can visit category show page" do
  context "with a valid URI /categories/category_name" do
    it "and see a list of all active items for the category" do
      magic = create(:category, title: "Magic")
      sci_fi = create(:category, title: "Sci-Fi")
      create(:item, title: "Dove", category: magic)
      create(:item, title: "Rabbit", category: magic)
      create(:item, title: "Light Saber", category: sci_fi)

      visit '/categories/magic'

      within(".items") do
        expect(page).to have_content("Dove")
        expect(page).to have_content("Rabbit")
        expect(page).to_not have_content("Light Saber")
      end
    end
  end

  context "with invalid URI /category_name" do
    it "and I see an error message" do
      create(:category, title: "Magic")

      expect { visit '/magic' }.to raise_error(ActionView::Template::Error)
    end
  end
end
