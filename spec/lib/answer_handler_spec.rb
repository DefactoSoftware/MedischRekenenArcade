require 'spec_helper'

describe AnswerHandler do
  include Rails.application.routes.url_helpers

  let(:user) { User.new(name: "marthyn", email:"marthyn@live.nl") }
  let(:challenge) { Challenge.new(number_of_problems: 5, name:"challenge") }
  let(:user_challenge) { UserChallenge.new(challenge:challenge, user:user) }
  let(:practicehandler_good) { CorrectPracticeAnswerHandler.new({}, user) }
  let(:practicehandler_bad) { IncorrectPracticeAnswerHandler.new({}, user) }
  let(:challenge_handler_good) { CorrectChallengeAnswerHandler.new({ challenge_id: challenge.id}, user, user_challenge)}
  let(:challenge_handler_dead) { IncorrectChallengeAnswerHandler.new({ challenge_id: challenge.id, damage: ChallengeAnswerHandler::STANDARD_DEATH_CEILING + 1 }, user, user_challenge) }
  let(:challenge_handler_wrong) { IncorrectChallengeAnswerHandler.new({ challenge_id: challenge.id}, user, user_challenge) }



  describe "#reset_challenge" do
    let(:session) { double("session", delete: "foo") }
    let(:handler) { IncorrectChallengeAnswerHandler.new(session, double, double(challenge: double)) }

    describe "deletes the session" do
      before(:each) do
        handler.reset_challenge!
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

  describe "#reset_streak!" do
    let(:handler) { AnswerHandler.new({streak: 1}, double)}
    it "should reset the sessions streak" do
      handler.reset_streak!
      expect(handler.session.streak).to eq(0)
    end
  end

  describe "#decrease_damage" do
    let(:handler) { AnswerHandler.new({ damage: 2 }, double)}
    it "should decrease to 1 when damage is 2" do
      handler.decrease_damage!
      expect(handler.session.damage).to eq(1)
    end

    let(:handler2) { AnswerHandler.new({damage:1}, double)}
    it "should return 0 when damage is 1" do
      handler2.decrease_damage!
      expect(handler2.session.damage).to eq(0)
    end
  end

  describe "#increase_streak" do
    let(:handler) { AnswerHandler.new({streak:0}, user) }
    it "should increase the streak" do
      handler.increase_streak!
      expect(handler.session.streak).to eq(1)
    end
  end

  let(:mock_user) { double("user", increase: true) }
  describe "#increase_points" do
    let(:handler) { AnswerHandler.new(double, mock_user) }
    it "should increase the points" do
      expect(mock_user).to receive(:increase_points).with(1)
      handler.increase_points!
    end
  end

  describe "#decrease_points" do
    describe "#increase_points" do
      let(:handler) { AnswerHandler.new(double, mock_user) }
      it "should decrease the points" do
        expect(mock_user).to receive(:decrease_points).with(1)
        handler.decrease_points!
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

describe AnswerHandlerFactory do
  let(:session) { double }
  let(:answer_is_correct) { double }
  let(:user) { double }
  let(:factory) { AnswerHandlerFactory.new(session, answer_is_correct, user) }

  describe "#initialize" do
    it "should initialize session" do
      expect(factory.instance_variable_get(:@session)).to eq(session)
    end

    it "should intialize answer_is_correct" do
      expect(factory.instance_variable_get(:@answer_is_correct)).to eq(answer_is_correct)
    end

    it "should initialize user" do
      expect(factory.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe "#build" do
    describe "when challenge" do
      let(:session) { { challenge: 1 } }

      before(:each) do
        expect(factory).to receive(:user_challenge).and_return(double(challenge: double))
      end

      describe "when answer is incorrect" do
        let(:answer_is_correct) { false }

        describe "when dead" do
          let(:session) { {damage: 6, challenge: 1} }
          it "should return an IncorrectChallengeAnswerHandler" do
            expect(factory.build).to be_instance_of(IncorrectChallengeAnswerHandler)
          end
        end

        describe "when not dead" do
          let(:session) { { damage: rand(0...5), challenge: 1 } }
          it "should return an IncorrectChallengeAnswerHandler" do
            expect(factory.build).to be_instance_of(IncorrectChallengeAnswerHandler)
          end
        end
      end

      describe "when answer is correct" do
        let(:session) { { challenge: 1 } }
        let(:answer_is_correct) { true }

        describe "when finished" do
          it "should return a CorrectChallengeAnswerHandler" do
            expect(factory.build).to be_instance_of(CorrectChallengeAnswerHandler)
          end
        end

        describe "when not finished" do
          it "should return a CorrectChallengeAnswerHandler" do
            expect(factory.build).to be_instance_of(CorrectChallengeAnswerHandler)
          end
        end
      end
    end

    describe "when practice" do
      let(:session) { { challenge: nil } }

      describe "when answer is incorrect" do
        let(:answer_is_correct) { false }

        it "should return an IncorrectPracticeAnswerHandler" do
          expect(factory.build).to be_instance_of(IncorrectPracticeAnswerHandler)
        end
      end

      describe "when answer is correct" do
        let(:answer_is_correct) { true }

        it "should return a CorrectPracticeAnswerHandler" do
          expect(factory.build).to be_instance_of(CorrectPracticeAnswerHandler)
        end
      end
    end
  end
end

describe GameSession do
  let(:game_session) { GameSession.new(session) }
  describe "#initialize" do
    describe "when challenge" do
      let(:session) { { challenge_id: double, start_time: double, damage: double, streak: double } }

      it "initializes damage" do
        expect(game_session.damage).to_not eq(nil)
      end

      it "initializes start_time" do
        expect(game_session.start_time).to_not eq(nil)
      end

      it "initializes challenge_id" do
        expect(game_session.challenge_id).to_not eq(nil)
      end

      it "initializes session" do
        expect(game_session.instance_variable_get(:@session)).to_not eq(nil)
      end

      it "initalizes streak" do
        expect(game_session.streak).to_not eq(nil)
      end
    end

    describe "when practice" do
      let(:session) { { streak: double } }
      it "does not initialize damage" do
        expect(game_session.damage).to eq(nil)
      end

      it "does not initialize start_time" do
        expect(game_session.start_time).to eq(nil)
      end

      it "does not initialize challenge_id" do
        expect(game_session.challenge_id).to eq(nil)
      end

      it "initializes session" do
        expect(game_session.instance_variable_get(:@session)).to_not eq(nil)
      end

      it "initalizes streak" do
        expect(game_session.streak).to_not eq(nil)
      end
    end
  end
end
