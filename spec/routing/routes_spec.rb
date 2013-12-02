require 'spec_helper'

describe "routing to" do
  describe "home" do
    it "to root" do
      expect(get: "/").to route_to("home#index")
    end
  end

  describe "friendships" do
    it "to #create" do
      expect(post: "/friendships").to route_to("friendships#create")
    end

    it "to #destroy" do
      expect(delete: "/friendships/1").to route_to(
        controller: "friendships",
        action: "destroy",
        id: "1"
      )
    end
  end

  describe "users" do
    it "to #index" do
      expect(get: "/users").to route_to("users#index")
    end
    it "to #show" do
      expect(get: "/users/1").to route_to(
        controller: "users",
        action: "show",
        id: "1"
      )
    end
  end

  describe "leaderboards" do
    it "to #index" do
      expect(get: "/leaderboards").to route_to("leaderboards#index")
    end
  end

  describe "practice" do
    it "to #index" do
      expect(get: "/practice").to route_to("problems#index")
    end
  end

  describe "answers" do
    it "to #create" do
      expect(post: "/answers").to route_to("answers#create")
    end
  end


end
