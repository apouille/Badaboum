require 'rails_helper'

RSpec.describe Product, type: :model do

	before(:each) do 
    @product = FactoryBot.create(:product)    
  end

  it "has a valid factory" do
    expect(build(:product)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@product).to be_a(Product)
    end

		describe "#title" do
    	it { expect(@product).to validate_presence_of(:title).with_message("Merci de remplir tous les champs obligatoires!") }
		end

		describe "#description" do
      it { expect(@product).to validate_presence_of(:description).with_message("Merci de remplir tous les champs obligatoires!") }
      it { expect(@product).to validate_length_of(:description).is_at_least(20).with_message("La description doit faire au minimum 20 caractères") }
		end

		describe "#price" do
      it { expect(@product).to validate_presence_of(:price).with_message("Merci de remplir tous les champs obligatoires!") }
      it { expect(@product).to validate_numericality_of(:price).only_integer.is_greater_than(1).with_message("Le prix doit être supérieur à 1€") }
		end
  end


  context "associations" do
  	it { expect(@product).to belong_to(:seller).class_name('User') }
  	it { expect(@product).to belong_to(:category) }
  	it { expect(@product).to belong_to(:size) }
  end
end