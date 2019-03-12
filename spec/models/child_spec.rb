require 'rails_helper'

RSpec.describe Child, type: :model do
	before(:each) do 
    @child = FactoryBot.create(:child)    
  end

  it "has a valid factory" do
    expect(build(:child)).to be_valid
  end

    context "validation" do
    it "is valid with valid attributes" do
      expect(@child).to be_a(Child)
    end
end
end