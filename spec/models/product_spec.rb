require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do 
    @product = FactoryBot.create(:product)
    @message = ": Ce champs est obligatoire!"  
  end

  it "has a valid factory" do
    expect(build(:product)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@product).to be_a(Product)
    end

    describe "#title" do
      it { expect(@product).to validate_presence_of(:title).with_message(@message) }
    end

    describe "#price" do
      it { expect(@product).to validate_presence_of(:price).with_message(@message) }
      it { expect(@product).to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(1).with_message("Le prix doit être supérieur ou égal à 1€") }
    end

    describe "#description" do
      it { expect(@product).to validate_presence_of(:description).with_message(@message) }
      it { expect(@product).to validate_length_of(:description).is_at_least(20).with_message(" La description doit faire au minimum 20 caractères") }
    end

    describe "#category" do
      it { expect(@product).to validate_presence_of(:category).with_message(@message) }
    end

    describe "#size" do
      it { expect(@product).to validate_presence_of(:size).with_message(@message) }
    end

    describe "#condition" do
      it { expect(@product).to validate_presence_of(:condition).with_message(@message) }
      it { should define_enum_for(:condition).with_values(Neuf:1, Bon:2, Moyen:3, Mauvais:4, Dégradé:5) }
    end    

    describe "#state" do
      it { expect(@product).to validate_presence_of(:state) }
      it { should define_enum_for(:state).with_values(in_stock:1, sold:2) }
    end    
  end


  context "public methods" do 
    describe "Upload picture" do    
      it "saves the image" do
        file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
        @product.pictures.attach(file)
        expect(@product.pictures).to be_attached
      end
    end 
  end 


  context "associations" do
    it { expect(@product).to belong_to(:seller).class_name('User') }
    it { expect(@product).to belong_to(:category) }
    it { expect(@product).to belong_to(:size) }
    it { expect(@product).to have_many(:comments).dependent(:destroy) }
    it { expect(@product).to have_one(:order) }
    it { expect(@product).to have_many(:wishlist_products).dependent(:destroy) }
  end


  context "scopes" do
    describe "cat" do

      before(:each) do 
        @stroller_cat = FactoryBot.create(:category)
        @book_cat = FactoryBot.create(:category)
        @stroller = FactoryBot.create(:product, category: @stroller_cat)
        @book = FactoryBot.create(:product, category: @book_cat)
        @products = Product.cat(@stroller_cat)  
      end

      it "should only return products with the stroller category" do
        expect(@products).to include(@stroller)
      end

      it "should not return products with another category" do
        expect(@products).to_not include(@book)
      end
    end
  end
end