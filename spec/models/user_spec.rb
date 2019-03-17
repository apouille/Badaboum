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
end
