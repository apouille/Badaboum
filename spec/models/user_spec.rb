require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do 
    @user = FactoryBot.create(:user)    
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
    end
  end


  context "public methods" do

    describe "the welcome_send method" do
      it "send a welcome email for a new user" do
        expect { FactoryBot.create(:user) }.to change{ ActionMailer::Base.deliveries.count }.by(1)
      end
    end

    describe "the create_profile method" do
      it "create a blank profile for a new user" do
        expect { FactoryBot.create(:user) }.to change{ Profile.count }.by(1)
      end
    end  
  end 


  context "associations" do 
    it { expect(@user).to have_many(:uploaded_products).class_name('Product') }
    it { expect(@user).to have_many(:orders) }
    it { expect(@user).to have_many(:comments) }
    it { expect(@user).to have_one(:profile).dependent(:destroy) }
  end 
end
