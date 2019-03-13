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

	   
	end

  context "associations" do
    it { expect(@child).to belong_to(:profile) }
   
  end


end