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

    describe "#title" do
      it { expect(@category).to validate_presence_of(:title) }
    end
    describe "#icon" do
      it { expect(@category).to validate_presence_of(:icon) }
    end
  end


  context "public methods" do 
    it { expect(Category.nested_array_of_cat).to include([@category.title, @category.id]) }
  end
  

  context "associations" do
    it { expect(@category).to have_many(:products) }
  end
end