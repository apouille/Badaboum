require 'rails_helper'

RSpec.describe Size, type: :model do
  before(:each) do 
    @size = FactoryBot.create(:size)    
  end

  it "has a valid factory" do
    expect(build(:size)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@size).to be_a(Size)
    end

    describe "#title" do
      it { expect(@size).to validate_presence_of(:title) }
    end
  end


  context "associations" do
    it { expect(@size).to have_many(:products) }
  end

end
