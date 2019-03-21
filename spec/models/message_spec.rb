require 'rails_helper'

RSpec.describe Message, type: :model do

  before(:each) do 
    @message = FactoryBot.create(:message)    
  end

  it "has a valid factory" do
    expect(build(:message)).to be_valid
  end


  context "validation" do
    it "is valid with valid attributes" do
      expect(@message).to be_a(Message)
    end

    describe "#body" do
      it { expect(@message).to validate_presence_of(:body) }
    end

    describe "#conversation_id" do
      it { expect(@message).to validate_presence_of(:conversation_id) }
    end

    describe "#user_id" do
      it { expect(@message).to validate_presence_of(:user_id) }
    end
  end

  context "public methods" do
    describe "the message_time method" do
      message = FactoryBot.create(:message, created_at: "2019-03-21 13:00:00")
      it { expect(message.message_time).to eq("21/03/19 à 13h00") }
    end
  end


  context "associations" do
    it { expect(@message).to belong_to(:conversation) }
    it { expect(@message).to belong_to(:user) }
  end
end
