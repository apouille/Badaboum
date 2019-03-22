require 'spec_helper'

feature "the buying process" do
  background do
    @user = FactoryBot.create(:user)
  end

  scenario "sign in then buy a product" do
    
    visit '/users/sign_in'

    within("#new_user") do
      fill_in 'Email', with: @user.email
      fill_in 'Mot de passe', with: @user.password
    end

    click_button 'Se connecter'

    expect(page).to have_content 'Se déconnecter'

    # click_link("Create event", :match => :first)

    # within("#event") do
    #   fill_in 'title', with: @event.title
    #   fill_in 'start_date', with: @event.start_date
    #   fill_in 'duration', with: @event.duration
    #   fill_in 'description', with: @event.description
    #   fill_in 'price', with: @event.price
    #   fill_in 'location', with: @event.location
    # end

    # click_button 'Create'

    # expect(page).to have_content 'Event successfully created'
  end
end

