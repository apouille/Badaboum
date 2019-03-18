require 'rails_helper'

RSpec.describe WishlistProduct, type: :model do
  before(:each) do 
    @wishlist = FactoryBot.create(:wishlist_product)    
  end

  it "has a valid factory" do
    expect(build(:wishlist_product)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@wishlist).to be_a(WishlistProduct)
    end
  end


  context "associations" do 
    it { expect(@wishlist).to belong_to(:product) }
    it { expect(@wishlist).to belong_to(:user) }
  end 
end
