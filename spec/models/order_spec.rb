require 'rails_helper'

RSpec.describe Order, type: :model do

  before(:each) do 
    @order = FactoryBot.create(:order)    
  end

  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@order).to be_a(Order)
    end

    describe "#status" do
      it { expect(@order).to validate_presence_of(:status) }
      it { should define_enum_for(:status).with_values(in_progress:1, paid_with_stripe:2) }
    end
  end


  context "associations" do
    it { expect(@order).to belong_to(:user) }
    it { expect(@order).to belong_to(:product) }
  end
end
