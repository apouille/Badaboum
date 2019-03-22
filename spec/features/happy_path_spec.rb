require 'spec_helper'

feature "the buying process" do
  background do
    @user = FactoryBot.create(:user)
  end

  scenario "user sign in then buy a product" do
    
    visit '/users/sign_in'

    within("#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Mot de passe', with: @user.password
    end

    click_button 'Se connecter'

    click_link_or_button("Je découvre")  


    


  end
end

