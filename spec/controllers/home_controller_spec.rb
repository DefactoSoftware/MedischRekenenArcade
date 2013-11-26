require 'spec_helper'

describe HomeController do
  describe "Index" do
    it "should return status 200" do
      get :index
      expect(response.status).to eq(200)
    end
  end


end
