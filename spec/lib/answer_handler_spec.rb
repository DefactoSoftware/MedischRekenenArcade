require 'spec_helper'
require 'support/devise'

describe AnswerHandler do
  let(:user) { User.new(name: "marthyn", email:"marthyn@live.nl") }
  let(:challenge) { Challenge.new(number_of_problems: 5, name:"challenge") }
  let(:user_challenge) { UserChallenge.new(challenge:challenge, user:user) }
  let(:practicehandler_good) { PracticeSession.new(true, {}, user) }
  let(:practicehandler_bad) { PracticeSession.new(false, {}, user) }
  let(:challenge_handler_good) { ChallengeSession.new(true, {challenge: challenge.id}, user, user_challenge)}
  let(:challenge_handler_dead) { ChallengeSession.new(false, {challenge: challenge.id, damage: ChallengeSession::STANDARD_DEATH_CEILING+1}, user, user_challenge) }
  let(:challenge_handler_wrong) { ChallengeSession.new(false, {challenge: challenge.id}, user, user_challenge) }

  describe ChallengeSession do
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
      challenge_handler_good = ChallengeSession.new(true, {challenge: challenge.id}, user, user_challenge)
      expect(challenge_handler_good.get_notice).to eq(I18n.t("challenge.finished", bonus: challenge.bonus))
    end

    it "should return answer is correct as notice when answer is wrong" do
      expect(challenge_handler_wrong.get_notice).to eq(I18n.t("answer.wrong"))
    end

    describe "#redirect_path" do
      describe "when finished" do
        it "should redirect to /challenges" do
          expect(challenge_handler_good).to receive(:finished).and_return(true)
          expect(challenge_handler_good.redirect_path).to eq("/challenges")
        end
      end

      describe "when dead" do
        it "should redirect to /challenges" do
          expect(challenge_handler_good).to receive(:is_dead).and_return(true)
          expect(challenge_handler_good.redirect_path).to eq("/challenges")
        end
      end
    end
  end

  describe PracticeSession do
    it "should return answer is correct notice on good answer" do
      expect(practicehandler_good.get_notice).to eq(I18n.t("answer.correct", points: PracticeSession::STANDARD_POINT_AMOUNT))
    end

    it "should return answer is wrong notice on bad answer" do
      expect(practicehandler_bad.get_notice).to eq(I18n.t("answer.wrong"))
    end
  end

  describe "#redirect_path" do
    it "should not redirect anywhere" do
      expect(practicehandler_good.redirect_path).to eq(nil)
    end
  end
end
