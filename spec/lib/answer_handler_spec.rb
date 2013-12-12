require 'spec_helper'
require 'support/devise'

describe AnswerHandler do
  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:user_challenge) { FactoryGirl.create(:user_challenge, challenge:challenge, user:user) }
  let(:practicehandler_good) { PracticeSession.new(true, {}, user.reload) }
  let(:practicehandler_bad) { PracticeSession.new(false, {}, user.reload) }
  let(:challenge_handler_good) { ChallengeSession.new(true, {challenge: challenge.id}, user.reload)}
  let(:challenge_handler_dead) { ChallengeSession.new(false, {challenge: challenge.id, damage: ChallengeSession::STANDARD_DEATH_CEILING+1}, user.reload) }
  let(:challenge_handler_wrong) { ChallengeSession.new(false, {challenge: challenge.id}, user.reload) }

  describe ChallengeSession do
    before :each do
      challenge.reload
      user_challenge.reload
    end

    it "should be dead when damage is higher than STANDARD_DEATH_CEILING" do
      expect(challenge_handler_dead.is_dead).to be(true)
    end

    it "should return message dead when damage is higher than STANDARD_DEATH_CEILING" do
      expect(challenge_handler_dead.get_notice).to eq(I18n.t("answer.dead"))
    end

    it "should return answer is correct as notice" do
      expect(challenge_handler_good.get_notice).to eq(I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT))
    end

    it "should return challenge finished as notice" do
      #setting amount good to number needed -1 so that adding a good answer will trigger finished
      user_challenge.update_attributes(amount_good: challenge.number_of_problems-1)
      challenge_handler_good = ChallengeSession.new(true, {challenge: challenge.id}, user.reload)
      expect(challenge_handler_good.get_notice).to eq(I18n.t("challenge.finished", bonus: challenge.bonus))
    end

    it "should return answer is correct as notice when answer is wrong" do
      expect(challenge_handler_wrong.get_notice).to eq(I18n.t("answer.wrong"))
    end
  end

  describe PracticeSession do
    it "should increase points on good answer" do
      practicehandler_good.handle
      expect(user.total_points).to eq(1)
    end

    it "should return answer is correct notice on good answer" do
      expect(practicehandler_good.get_notice).to eq(I18n.t("answer.correct", points: PracticeSession::STANDARD_POINT_AMOUNT))
    end

    it "should not increase points on bad answer" do
      practicehandler_bad.handle
      expect(user.total_points).to eq(0)
    end

    it "should return answer is wrong notice on bad answer" do
      expect(practicehandler_bad.get_notice).to eq(I18n.t("answer.wrong"))
    end
  end
end
