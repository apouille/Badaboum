require 'rails_helper'

RSpec.describe Category, type: :model do
	before(:each) do 
    @category = FactoryBot.create(:category)    
  end

  it "has a valid factory" do
    expect(build(:category)).to be_valid
  end

    context "validation" do
    it "is valid with valid attributes" do
      expect(@category).to be_a(Category)
    end
end
end