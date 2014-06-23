require 'spec_helper'

describe UserGroupsController, :type => :controller do
  describe "POST create user group" do
    let(:user_group_attributes) { FactoryGirl.attributes_for(:user_group) }

    it "creates a report with text" do
      @request.env['HTTP_REFERER'] = root_path
      post :create, user_group: user_group_attributes
      expect(UserGroup.last.name).to eq(user_group_attributes[:name])
    end
  end
end
