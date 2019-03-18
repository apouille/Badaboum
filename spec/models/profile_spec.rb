require 'rails_helper'

RSpec.describe Profile, type: :model do
  before(:each) do
    @profile = FactoryBot.create(:profile)
    @message = "Merci de remplir tous les champs obligatoires!"
  end

  it "has a valid factory" do
      expect(build(:profile)).to be_valid
  end

  it "is valid with valid attributes" do
    expect(@profile).to be_a(Profile)
  end

  #A blank profile is created after sign up, thus validation only occur on update
  context "validation on update" do

    describe "#first_name" do
      it { expect(@profile).to validate_presence_of(:first_name).on(:update).with_message(@message) }
    end

    describe "#last_name" do
      it { expect(@profile).to validate_presence_of(:last_name).on(:update).with_message(@message) }
    end

    describe "#street" do
      it { expect(@profile).to validate_presence_of(:street).on(:update).with_message(@message) }
    end

    describe "#city" do
      it { expect(@profile).to validate_presence_of(:city).on(:update).with_message(@message) }
    end

    describe "#zip_code" do
      it { expect(@profile).to validate_presence_of(:zip_code).on(:update).with_message(@message) }
      it { is_expected.to allow_value("2a004").for(:zip_code).on(:update) }
      it { is_expected.to allow_value("2A004").for(:zip_code).on(:update) }
      it { is_expected.to allow_value("95600").for(:zip_code).on(:update) }
      it { is_expected.to_not allow_value("100000").for(:zip_code).on(:update).with_message("Le code postal est invalide") }
      it { is_expected.to_not allow_value("0000").for(:zip_code).on(:update).with_message("Le code postal est invalide") }
    end

    describe "#country" do
      it { expect(@profile).to validate_presence_of(:country).on(:update).with_message(@message) }
    end

    describe "#phone_number" do
      it { is_expected.to allow_value("0610261513").for(:phone_number).on(:update) }
      it { is_expected.to allow_value("0720267214").for(:phone_number).on(:update) }
      it { is_expected.to allow_value("0033610261513").for(:phone_number).on(:update) }
      it { is_expected.to_not allow_value("610261513").for(:phone_number).on(:update).with_message("Entrez un numéro français, s'il vous plait !") }
      it { is_expected.to_not allow_value("0000000000").for(:phone_number).on(:update).with_message("Entrez un numéro français, s'il vous plait !") }
    end

    describe "Upload profil picture" do    
      it "saves the image" do
        file = fixture_file_upload(Rails.root.join('public', 'apple-touch-icon.png'), 'image/png')
        @profile.profil_picture.attach(file)
        expect(@profile.profil_picture).to be_attached
      end
    end
  end

  context "public methods" do

    describe "the address method" do
      profile = FactoryBot.create(:profile)
      profile.update(first_name: "Bastien", last_name: "Hiel", street: "5 Parvis Alan Turing", city: "Paris", zip_code: "75013")
      it { expect(profile.address).to eq("5 Parvis Alan Turing, Paris, France") }
      it { expect(profile.latitude).to be_within(0.5).of(48.8) }
      it { expect(profile.longitude).to be_within(0.5).of(2.3) }
    end 
  end 

  context "associations" do
    it { expect(@profile).to belong_to(:user) }
    it { expect(@profile).to have_many(:children) }
  end

end
