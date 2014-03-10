require 'spec_helper'

describe Guest do
  let(:guest) { Guest.new }

  it "has a name method" do
    expect(Guest).to have_method :name
  end

  it "has a username method" do
    expect(Guest).to have_method :username
  end

  it "has a profilepicture_url method" do
    expect(Guest).to have_method :profilepicture_url
  end

  describe "Answers" do
    it "has the method" do
      expect(Guest).to have_method :answers
    end

    it "returns an empty relation" do
      expect(guest.answers).to be_a(ActiveRecord::Relation)
    end
  end

  describe "UserGroup" do
    it "has the method" do
      expect(Guest).to have_method :user_group
    end

    it "returns an empty relation" do
      expect(guest.user_group).to be_a(ActiveRecord::Relation)
    end
  end

  describe "Activities" do
    it "has the method" do
      expect(Guest).to have_method :activities
    end

    it "returns an empty relation" do
      expect(guest.activities).to be_a(ActiveRecord::Relation)
    end
  end

  describe "Recent Activities" do
    it "has the method" do
      expect(Guest).to have_method :recent_activities
    end

    it "returns an empty relation" do
      expect(guest.recent_activities).to be_a(ActiveRecord::Relation)
    end
  end

  it "has a friends with method" do
    expect(Guest).to have_method :friends_with?
  end
end
