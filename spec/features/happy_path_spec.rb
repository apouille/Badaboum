require 'spec_helper'

feature "the buying process" do
  background do
    @user = FactoryBot.create(:user)
    @product = FactoryBot.create(:product)
  end

  scenario "user sign in then buy a product" do
    
    visit '/users/sign_in'

    within("#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Mot de passe', with: @user.password
    end

    click_button 'Se connecter'

    click_link_or_button("Je découvre")

    page.find(:xpath, '//*[@id="products_grid"]/div[1]/div/div[1]/div/a').click
    
    click_link_or_button("Acheter ce produit")  

    expect(page).to have_content("Méthode de paiement")
  end
end

