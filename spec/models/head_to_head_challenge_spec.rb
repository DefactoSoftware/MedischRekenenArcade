# == Schema Information
#
# Table name: head_to_head_challenges
#
#  id            :integer          not null, primary key
#  challenger_id :integer
#  challenged_id :integer
#  challenge_id  :integer
#  points_bet    :integer
#  status        :integer          default(0)
#  created_at    :datetime
#  updated_at    :datetime
#

require "spec_helper"

describe HeadToHeadChallenge do
  describe "Associations" do
    it { should belong_to(:challenger) }
    it { should belong_to(:challenged) }
    it { should belong_to(:challenge) }
    it { should have_many(:user_challenges) }

  end

  describe "Status" do
    it "should start with open status" do
      head_to_head_challenge = create(:head_to_head_challenge)
      expect(head_to_head_challenge.status).to eq("open")
      expect(head_to_head_challenge.open?).to be(true)
    end
  end

  describe "Checking if the challenge is finished" do
    let(:head_to_head_challenge) { create(:head_to_head_challenge) }
    let(:head_to_head_challenge_no_user_challenges) do
      create(:head_to_head_challenge)
    end
    let(:challenger_user_challenge) do
      create(:user_challenge,
             user: head_to_head_challenge.challenger,
             challenge: head_to_head_challenge.challenge,
             head_to_head_challenge: head_to_head_challenge)
    end
    let(:challenged_user_challenge) do
      create(:user_challenge,
             user: head_to_head_challenge.challenged,
             challenge: head_to_head_challenge.challenge,
             head_to_head_challenge: head_to_head_challenge)
    end

    it "returns false if there are no user_challenges" do
      expect(head_to_head_challenge.check_finish).to be(false)
    end

    it "returns false if the amount
        of answers is less than number of problems" do
      rand = rand(0..(
        head_to_head_challenge.challenge.number_of_problems - 1))

      challenged_user_challenge.reload.update_attributes(
        amount_good: rand)

      expect(head_to_head_challenge.check_finish).to be(false)
    end

    it "returns true if both user challenges
        have an equal amount of answers to the number of problems" do
      challenged_user_challenge.reload.update_attributes(
        amount_good: head_to_head_challenge.challenge.number_of_problems)

      challenger_user_challenge.reload.update_attributes(
        amount_fail: head_to_head_challenge.challenge.number_of_problems)
      expect(head_to_head_challenge.check_finish).to be(true)
    end
  end

  describe "Notifying users" do
    it "should create notifications for both users after create" do
      head_to_head_challenge = create(:head_to_head_challenge)
      challenger_notification = head_to_head_challenge.challenger
                                                      .notifications
                                                      .last
      challenged_notification = head_to_head_challenge.challenged
                                                      .notifications
                                                      .last
      expect(challenger_notification.text).to eq(
        "notifications.head_to_head_challenge.challenger.text")
      expect(challenged_notification.text).to eq(
        "notifications.head_to_head_challenge.challenged.text")
      expect(challenger_notification.title).to eq(
        "notifications.head_to_head_challenge.challenger.title")
      expect(challenged_notification.title).to eq(
        "notifications.head_to_head_challenge.challenged.title")
    end
  end
end
