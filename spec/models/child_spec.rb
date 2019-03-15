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

		describe "#nickname" do
	    it { expect(@child).to validate_presence_of(:nickname).with_message("Merci de remplir tous les champs du formulaire!") }
	  end

	  describe "#sex" do
	    it { expect(@child).to validate_presence_of(:sex).with_message("Merci de remplir tous les champs du formulaire!") }
	  end

	  describe "#birthday" do
	  	it { expect(@child).to validate_presence_of(:birthday).with_message("Merci de remplir tous les champs du formulaire!") }
	  end

	  describe "#birthday_cannot_be_in_the_futur" do
	    it { is_expected.to allow_value("03/05/1991").for(:birthday) }
	    it { is_expected.to allow_value("01/12/1976").for(:birthday) }
	    it { is_expected.to_not allow_value("01/12/2055").for(:birthday) }
	    it { is_expected.to_not allow_value("03/05/2040").for(:birthday) }
	  end	   
	end


  context "associations" do
  	it { expect(@child).to belong_to(:profile) }
  end
end