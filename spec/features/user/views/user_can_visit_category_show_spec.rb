require 'rails_helper'

RSpec.describe "As a visitor can visit category show page" do
  it " can visit category show page" do
    category = create(:category)

    visit category_path(category)

    expect(current_path).to eq("/categories/#{category.slug}")
  end
end
