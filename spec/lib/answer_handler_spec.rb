require 'spec_helper'
require 'support/devise'

describe AnswerHandler do
  include Rails.application.routes.url_helpers

  let(:user) { User.new(name: "marthyn", email:"marthyn@live.nl") }
  let(:challenge) { Challenge.new(number_of_problems: 5, name:"challenge") }
  let(:user_challenge) { UserChallenge.new(challenge:challenge, user:user) }
  let(:practicehandler_good) { CorrectPracticeAnswerHandler.new({}, user) }
  let(:practicehandler_bad) { IncorrectPracticeAnswerHandler.new({}, user) }
  let(:challenge_handler_good) { CorrectChallengeAnswerHandler.new({ challenge: challenge.id}, user, user_challenge)}
  let(:challenge_handler_dead) { IncorrectChallengeAnswerHandler.new({ challenge: challenge.id, damage: ChallengeAnswerHandler::STANDARD_DEATH_CEILING + 1 }, user, user_challenge) }
  let(:challenge_handler_wrong) { IncorrectChallengeAnswerHandler.new({ challenge: challenge.id}, user, user_challenge) }



  describe "#reset_challenge" do
    let(:session) { double("session", delete: "foo") }
    let(:handler) { IncorrectChallengeAnswerHandler.new(session, double) }

    describe "deletes the session" do
      before(:each) do
        handler.reset_challenge
      end

      it "damage" do
        expect(session).to have_received(:delete).with(:damage)
      end

      it "start" do
        expect(session).to have_received(:delete).with(:start)
      end

      it "challenge" do
        expect(session).to have_received(:delete).with(:challenge)
      end
    end
  end

  describe "#decrease_damage" do
    let(:handler) { AnswerHandler.new(double, {streak: 1}, double)}
    it "should reset the sessions streak" do
      handler.reset_streak
      expect(handler.session[:streak]).to eq(0)
    end
  end

  describe "#decrease_damage" do
    let(:handler) { AnswerHandler.new(double, { damage: 2 }, double)}
    it "should decrease to 1 when damage is 2" do
      handler.decrease_damage
      expect(handler.session[:damage]).to eq(1)
    end

    let(:handler2) { AnswerHandler.new(double, {damage:1}, double)}
    it "should return 0 when damage is 1" do
      handler2.decrease_damage
      expect(handler2.session[:damage]).to eq(0)
    end
  end

  describe "#increase_streak" do
    let(:handler) { AnswerHandler.new(double, {streak:0}, user) }
    it "should increase the streak" do
      handler.increase_streak
      expect(handler.session[:streak]).to be(1)
    end
  end

  let(:mock_user) { double("user", increase: true) }
  describe "#increase_points" do
    let(:handler) { AnswerHandler.new(double, double, mock_user) }
    it "should increase the points" do
      expect(mock_user).to receive(:increase_points).with(1)
      handler.increase_points
    end
  end

  describe "#decrease_points" do
    describe "#increase_points" do
      let(:handler) { AnswerHandler.new(double, double, mock_user) }
      it "should decrease the points" do
        expect(mock_user).to receive(:decrease_points).with(1)
        handler.decrease_points
      end
    end
  end

  describe ChallengeAnswerHandler do
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
      challenge_handler_good = CorrectChallengeAnswerHandler.new({challenge: challenge.id}, user, user_challenge)
      expect(challenge_handler_good.get_notice).to eq(I18n.t("challenge.finished", bonus: challenge.bonus))
    end

    it "should return answer is correct as notice when answer is wrong" do
      expect(challenge_handler_wrong.get_notice).to eq(I18n.t("answer.wrong"))
    end

    describe "#redirect_path" do
      describe "when finished" do
        it "should redirect to /challenges" do
          expect(challenge_handler_good).to receive(:finished).and_return(true)
          expect(challenge_handler_good.redirect_path).to eq(challenges_path)
        end
      end

      describe "when dead" do
        it "should redirect to /challenges" do
          expect(challenge_handler_good).to receive(:is_dead).and_return(true)
          expect(challenge_handler_good.redirect_path).to eq(challenges_path)
        end
      end
    end
  end

  describe PracticeAnswerHandler do
    it "should return answer is correct notice on good answer" do
      expect(practicehandler_good.get_notice).to eq(I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT))
    end

    it "should return answer is wrong notice on bad answer" do
      expect(practicehandler_bad.get_notice).to eq(I18n.t("answer.wrong"))
    end
  end

  describe "#redirect_path" do
    it "should not redirect anywhere" do
      expect(practicehandler_good.redirect_path).to eq(practice_path)
    end
  end
end

