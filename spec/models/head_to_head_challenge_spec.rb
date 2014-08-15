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

  describe "Check the winner" do
    let(:head_to_head_challenge) { create(:head_to_head_challenge) }
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

    it "returns none when not finished" do
      head_to_head_challenge.update_attributes(status: :open)
      expect(head_to_head_challenge.winner).to eq(User.none)
    end

    it "returns challenger when score is higher" do
      head_to_head_challenge.update_attributes(status: :finished)
      challenger_user_challenge.update_attributes(amount_good: 10)
      challenged_user_challenge.update_attributes(amount_fail: 10)
      expect(head_to_head_challenge.winner).to(
        eq(head_to_head_challenge.challenger))
    end

    it "returns challenged when score is higher" do
      head_to_head_challenge.update_attributes(status: :finished)
      challenger_user_challenge.update_attributes(amount_fail: 10)
      challenged_user_challenge.update_attributes(amount_good: 10)
      expect(head_to_head_challenge.winner).to(
        eq(head_to_head_challenge.challenged))
    end

    it "returns challenger when score equal and time lower" do
      head_to_head_challenge.update_attributes(status: :finished)
      challenger_user_challenge.update_attributes(amount_good: 10, created_at: DateTime.now)
      challenged_user_challenge.update_attributes(amount_good: 10, created_at: DateTime.now - 10.minutes)
      expect(head_to_head_challenge.winner).to(
        eq(head_to_head_challenge.challenger))
    end
  end

  describe "Other player" do
    let(:head_to_head_challenge) { create(:head_to_head_challenge) }
    it "returns the challenger" do
      expect(head_to_head_challenge.
             other_player(head_to_head_challenge.
                          challenged)).to(
        eq(head_to_head_challenge.challenger))

    end

    it "returns the challenged" do
      expect(head_to_head_challenge.
             other_player(head_to_head_challenge.
                          challenger)).to(
        eq(head_to_head_challenge.challenged))
    end

    it "checks the challenger" do
      expect(head_to_head_challenge.
             user_is_challenger(head_to_head_challenge.
                                challenger)).to(
        eq(true))
    end
  end

  describe "Check user is finished" do
    let(:head_to_head_challenge) { create(:head_to_head_challenge) }
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

    describe "challenger" do
      it "is finished" do
        challenger_user_challenge.update_attributes(amount_good: 10)
        expect(head_to_head_challenge.
               user_finished(head_to_head_challenge.challenger)).to(
          eq(true))
      end

      it "is not finished" do
        expect(head_to_head_challenge.
               user_finished(head_to_head_challenge.challenger)).to(
          eq(false))
      end
    end

    describe "challenged" do
      it "is finished" do
        challenged_user_challenge.update_attributes(amount_good: 10)
        expect(head_to_head_challenge.
               user_finished(head_to_head_challenge.challenged)).to(
          eq(true))
      end

      it "is not finished" do
        expect(head_to_head_challenge.
               user_finished(head_to_head_challenge.challenged)).to(
          eq(false))
      end
    end
  end
end
