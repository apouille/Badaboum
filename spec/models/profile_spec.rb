require 'rails_helper'

RSpec.describe Profile, type: :model do
  before(:each) do
      @profile = FactoryBot.create(:profile)
  end

  it "has a valid factory" do
      expect(build(:profile)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@profile).to be_a(Profile)
    end

    describe "#first_name" do
      it { expect(@profile).to validate_presence_of(:first_name).with_message("Merci de remplir tous les champs obligatoires!") }
    end

    describe "#last_name" do
      it { expect(@profile).to validate_presence_of(:last_name).with_message("Merci de remplir tous les champs obligatoires!") }
    end

    describe "#street" do
      it { expect(@profile).to validate_presence_of(:street).with_message("Merci de remplir tous les champs obligatoires!") }
    end

    describe "#city" do
      it { expect(@profile).to validate_presence_of(:city).with_message("Merci de remplir tous les champs obligatoires!") }
    end

    describe "#zip_code" do
      it { expect(@profile).to validate_presence_of(:zip_code).with_message("Merci de remplir tous les champs obligatoires!") }
      it { is_expected.to allow_value("2a004").for(:zip_code).on(:update) }
      it { is_expected.to allow_value("2A004").for(:zip_code).on(:update) }
      it { is_expected.to allow_value("95600").for(:zip_code).on(:update) }
      it { is_expected.to_not allow_value("100000").for(:zip_code).on(:update).with_message("Le code postal est invalide") }
    end

    describe "#country" do
      it { expect(@profile).to validate_presence_of(:country).with_message("Merci de remplir tous les champs obligatoires!") }
    end

    describe "#phone_number" do
      it { is_expected.to allow_value("0610261513").for(:phone_number) }
      it { is_expected.to allow_value("0720267214").for(:phone_number) }
      it { is_expected.to allow_value("0033610261513").for(:phone_number) }
    end

  end

  context "associations" do
    it { expect(@profile).to belong_to(:user) }
    it { expect(@profile).to have_many(:children) }
  end

end
