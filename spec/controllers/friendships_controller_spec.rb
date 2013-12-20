require 'spec_helper'

describe FriendshipsController do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:friendship_attributes) { FactoryGirl.attributes_for(:friendship, friend_id: user2.id) }

  describe "POST create" do
    before :each do
      @request.env['HTTP_REFERER'] = root_path
      sign_in user1.reload
    end

    it "returns 201" do
      post :create, friendship: friendship_attributes
      expect(response.status).to eq(200)
    end

    it "creates a new friendship" do
      friendship_attributes = FactoryGirl.attributes_for(:friendship, friend_id: user2.id)
      expect {
        post :create, friendship: friendship_attributes
      }.to change(Friendship, :count).by(1)
    end

    it "does not create new friendship if already exists" do

    end
  end

  describe "DELETE destroy" do
    it "deletes a friendship" do
      @request.env['HTTP_REFERER'] = root_path
      sign_in user1.reload
      friendship = Friendship.create(user_id: user1.id, friend_id: user2.id)
      expect {
        get :destroy, id: friendship.id
      }.to change(Friendship, :count).by(-1)
    end
  end
end
