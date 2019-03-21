require 'rails_helper'

RSpec.describe Conversation, type: :model do

  before(:each) do 
    @conversation = FactoryBot.create(:conversation)    
  end

  it "has a valid factory" do
    expect(build(:conversation)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@conversation).to be_a(Conversation)
    end
  end

  context "associations" do
    it { expect(@conversation).to belong_to(:sender).class_name('User') }
    it { expect(@conversation).to belong_to(:recipient).class_name('User') }
    it { expect(@conversation).to have_many(:messages).dependent(:destroy) }
  end

  context "scopes" do
    describe "between" do

      before(:each) do 
        @user_1 = FactoryBot.create(:user)
        @user_2 = FactoryBot.create(:user)
        @user_3 = FactoryBot.create(:user)
        @conversation = Conversation.create(sender: @user_1, recipient: @user_2)
      end

      it "should return that the conversation already exist" do
        expect(Conversation.between(@user_1, @user_2)).to be_present
      end

      it "should also return that the conversation already exist" do
        expect(Conversation.between(@user_2, @user_1)).to be_present
      end

      it "should not return that the conversation already exist" do
        expect(Conversation.between(@user_1, @user_3)).not_to be_present
      end

    end
  end
end
