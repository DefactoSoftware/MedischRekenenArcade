# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  username               :string(255)      not null
#  name                   :string(255)
#  profilepicture_url     :string(255)      default("http://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/John_Doe.jpg/220px-John_Doe.jpg")
#  created_at             :datetime
#  updated_at             :datetime
#  user_group_id          :integer
#  sash_id                :integer
#  level                  :integer          default(0)
#

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  it "should have a default profile picture when not set" do
    User.create(email: "newuser@example.com", username: "test", password: "test1234")
    expect change(User, :count).by(1)
  end

  it "should not create a user when username is not specified" do
    expect { User.create(email: "test2@example.com", password: "test1234") }.to raise_error
  end

  it "should not create a user when email is not specified" do
    expect { User.create(email: "test2@example.com", password: "test1234") }.to raise_error
  end

  it "should accumulate points" do
    user = User.create(email: "test@example.com", username: "test", password: "test1234")
    user.increase_points(6)
    user.decrease_points(3)
    user.increase_points(9)
    expect(user.points).to eq(12)
  end

  describe "#recent_activities" do
    it "should return a list of activities" do
      Activity.create(
        user: user,
        trackable: Challenge.new,
        action: "create"
      )

      expect(user.recent_activities.first).to be_a(Activity)
    end

    it "should return standard amount of most recent activities" do
      6.times do
        Activity.create(
          user: user,
          trackable: Challenge.new,
          action: "create"
        )
      end

      expect(user.recent_activities.count).to eq(6)
    end
  end
end
