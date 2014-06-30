require "spec_helper"

describe AnswerHandler do
  include Rails.application.routes.url_helpers

  let(:user) { create(:user, name: "marthyn", email: "marthyn@live.nl") }
  let(:user2) { create(:user, name: "karel", email: "karel@live.nl") }
  let(:challenge) { Challenge.new(number_of_problems: 5, name: "challenge") }
  let(:head_to_head_challenge) do
    create(:head_to_head_challenge,
           challenger: user,
           challenged: user2,
           challenge: challenge)
  end
  let(:head_to_head_user_challenge) do
    UserChallenge.new(challenge: challenge,
                      user: user,
                      head_to_head_challenge: head_to_head_challenge)
  end
  let(:user_challenge) { UserChallenge.new(challenge: challenge, user: user) }
  let(:practicehandler_good) do
    CorrectPracticeAnswerHandler.new({}, user, double)
  end
  let(:practicehandler_bad) do
    IncorrectPracticeAnswerHandler.new({}, user, double)
  end
  let(:guesthandler_good) { CorrectGuestAnswerHandler.new({}, user, double) }
  let(:guesthandler_bad) { IncorrectGuestAnswerHandler.new({}, user, double) }
  let(:challenge_handler_good) do
    CorrectChallengeAnswerHandler.new(
      { challenge_id: challenge.id }, user, user_challenge, double)
  end

  let(:challenge_handler_dead) do
    damage = ChallengeAnswerHandler::STANDARD_DEATH_CEILING + 1
    IncorrectChallengeAnswerHandler.new({ challenge_id: challenge.id,
                                          damage: damage
                                        },
                                        user,
                                        user_challenge,
                                        double)
  end

  let(:challenge_handler_wrong) do
    IncorrectChallengeAnswerHandler.new({ challenge_id: challenge.id },
                                        user.reload,
                                        user_challenge,
                                        double)
  end
  let(:head_to_head_challenge_handler_good) do
    CorrectHeadToHeadChallengeAnswerHandler.new({ challenge_id: challenge.id },
                                                user,
                                                head_to_head_user_challenge,
                                                double)
  end
  let(:head_to_head_challenge_handler_wrong) do
    IncorrectHeadToHeadChallengeAnswerHandler.new(
      { challenge_id: challenge.id },
      user,
      head_to_head_user_challenge,
      double)
  end

  describe "#reset_challenge" do
    let(:session) { double("session", delete: "foo") }
    let(:handler) do
      IncorrectChallengeAnswerHandler.new(session,
                                          double,
                                          double(challenge: double),
                                          double)
    end

    describe "deleting the session" do
      before(:each) do
        handler.reset_challenge!
      end

      it "#damage" do
        expect(session).to have_received(:delete).with(:damage)
      end

      it "#start" do
        expect(session).to have_received(:delete).with(:start)
      end

      it "#challenge" do
        expect(session).to have_received(:delete).with(:challenge)
      end
    end
  end

  describe "#reset_streak!" do
    let(:handler) { AnswerHandler.new({ streak: 1 }, double, double) }
    it "resets the sessions streak" do
      handler.reset_streak!
      expect(handler.session.streak).to eq(0)
    end
  end

  describe "#decrease_damage" do
    let(:handler) { AnswerHandler.new({ damage: 2 }, double, double) }
    it "decreases to 1 when damage is 2" do
      handler.decrease_damage!
      expect(handler.session.damage).to eq(1)
    end

    let(:handler2) { AnswerHandler.new({ damage: 1 }, double, double) }
    it "returns 0 when damage is 1" do
      handler2.decrease_damage!
      expect(handler2.session.damage).to eq(0)
    end
  end

  describe "#increase_streak" do
    let(:handler) { AnswerHandler.new({ streak: 0 }, user, double) }
    it "increases the streak" do
      handler.increase_streak!
      expect(handler.session.streak).to eq(1)
    end
  end

  let(:mock_user) { double("user", increase: true) }
  describe "#increase_points" do
    let(:handler) { AnswerHandler.new(double, mock_user, double) }
    it "increases the points" do
      expect(mock_user).to receive(:increase_points).with(1)
      handler.increase_points!
    end
  end

  describe "#decrease_points" do
    let(:handler) { AnswerHandler.new(double, mock_user, double) }
    it "decreases the points" do
      expect(mock_user).to receive(:decrease_points).with(1)
      handler.decrease_points!
    end
  end

  describe ChallengeAnswerHandler do
    it "is dead when damage is higher than standard death" do
      expect(challenge_handler_dead.dead?).to be(true)
    end

    it "returns message dead when damage is higher than standard death" do
      expect(challenge_handler_dead.get_notice).to eq(I18n.t("answer.dead"))
    end

    it "returns answer is correct as notice" do
      expect(challenge_handler_good.get_notice).to eq(
        I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
      )
    end

    it "returns challenge finished as notice" do
      # setting amount good to number needed -1 so that
      # adding a good answer will trigger finished
      user_challenge
      .update_attributes(amount_good: challenge.number_of_problems)
      challenge_handler_good = CorrectChallengeAnswerHandler.new(
        { challenge: challenge.id }, user, user_challenge, double
      )
      expect(challenge_handler_good.get_notice).to eq(
        I18n.t("challenge.finished", bonus: challenge.bonus)
      )
    end

    it "returns answer is correct as notice when answer is wrong" do
      expect(challenge_handler_wrong.get_notice).to eq(I18n.t("answer.wrong"))
    end

    describe "#redirect_path" do
      describe "when finished" do
        it "redirects to /challenges" do
          expect(challenge_handler_good).to receive(:finished).and_return(true)
          expect(challenge_handler_good.redirect_path(double))
          .to eq(challenges_path)
        end
      end

      describe "when dead" do
        it "redirects to /challenges" do
          expect(challenge_handler_good).to receive(:dead?).and_return(true)
          expect(challenge_handler_good.redirect_path(double))
          .to eq(challenges_path)
        end
      end
    end
  end

  describe HeadToHeadChallengeAnswerHandler do
    it "returns answer is correct as notice" do
      expect(head_to_head_challenge_handler_good.get_notice).to eq(
        I18n.t("answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT)
      )
    end

    it "returns challenge finished as notice" do
      # setting amount good to number needed -1 so that
      # adding a good answer will trigger finished
      head_to_head_user_challenge.update_attributes(
        amount_good: challenge.number_of_problems)

      CorrectChallengeAnswerHandler.new(
        { challenge: challenge.id }, user, user_challenge, double
      )
      expect(head_to_head_challenge_handler_good.get_notice).to eq(
        I18n.t("head_to_head_challenge.finished")
      )
    end

    it "returns answer is correct as notice when answer is wrong" do
      expect(head_to_head_challenge_handler_wrong.get_notice)
      .to eq(I18n.t("answer.wrong"))
    end

    describe "#redirect_path" do
      describe "when finished" do
        it "redirects to /home" do
          expect(head_to_head_challenge_handler_good).to(
            receive(:finished).and_return(true))

          expect(head_to_head_challenge_handler_good.redirect_path(double)).to(
            eq(user_challenge_path(user, head_to_head_challenge)))
        end
      end
    end
  end

  describe PracticeAnswerHandler do
    it "returns answer is correct notice on good answer" do
      expect(practicehandler_good.get_notice)
      .to eq(I18n.t(
        "answer.correct", points: AnswerHandler::STANDARD_POINT_AMOUNT))
    end

    it "returns answer is wrong notice on bad answer" do
      expect(practicehandler_bad.get_notice).to eq(I18n.t("answer.wrong"))
    end
  end

  describe GuestAnswerHandler do
    it "returns answer is correct notice on good answer" do
      expect(guesthandler_good.get_notice)
      .to eq(I18n.t("answer.correct",
                    points: AnswerHandler::STANDARD_POINT_AMOUNT) +
                    I18n.t("answer.call_to_register"))
    end

    it "returns answer is wrong notice on bad answer" do
      expect(guesthandler_bad.get_notice)
      .to eq(I18n.t("answer.wrong") + I18n.t("answer.call_to_register"))
    end
  end

  describe "#redirect_path" do
    it "does not redirect anywhere" do
      expect(practicehandler_good.redirect_path(double))
      .to eq(practice_path + "?problem=#{double.class.name}")
    end
  end
end

describe AnswerHandlerFactory do
  let(:session) { double }
  let(:answer_is_correct) { double }
  let(:user) { double(guest?: false) }
  let(:skill) { double }
  let(:user_challenge) do
    double(challenge: double,
           head_to_head_challenge: nil)
  end
  let(:factory) do
    AnswerHandlerFactory.new(session,
                             answer_is_correct,
                             user,
                             skill,
                             user_challenge)
  end

  describe "#initialize" do
    it "initializes session" do
      expect(factory.instance_variable_get(:@session))
      .to eq(session)
    end

    it "intializes answer_is_correct" do
      expect(factory.instance_variable_get(:@answer_is_correct))
      .to eq(answer_is_correct)
    end

    it "initializes user" do
      expect(factory.instance_variable_get(:@user)).to eq(user)
    end
  end

  describe "#build" do
    describe "when challenge" do
      let(:session) { { challenge: 1 } }

      before(:each) do
        allow(factory).to receive(:user_challenge) do
          double(challenge: double,
                 head_to_head_challenge: nil)
        end
      end

      describe "when answer is incorrect" do
        let(:answer_is_correct) { false }

        describe "when dead" do
          let(:session) { { damage: 6, challenge: 1 } }
          it "returns an IncorrectChallengeAnswerHandler" do
            expect(factory.build)
            .to be_instance_of(IncorrectChallengeAnswerHandler)
          end
        end

        describe "when not dead" do
          let(:session) { { damage: rand(0...5), challenge: 1 } }
          it "returns an IncorrectChallengeAnswerHandler" do
            expect(factory.build)
            .to be_instance_of(IncorrectChallengeAnswerHandler)
          end
        end
      end

      describe "when answer is correct" do
        let(:session) { { challenge: 1 } }
        let(:answer_is_correct) { true }

        describe "when finished" do
          it "returns a CorrectChallengeAnswerHandler" do
            expect(factory.build)
            .to be_instance_of(CorrectChallengeAnswerHandler)
          end
        end

        describe "when not finished" do
          it "returns a CorrectChallengeAnswerHandler" do
            expect(factory.build)
            .to be_instance_of(CorrectChallengeAnswerHandler)
          end
        end
      end
    end

    describe "when practice" do
      let(:session) { { challenge: nil } }

      describe "when answer is incorrect" do
        let(:answer_is_correct) { false }

        it "returns an IncorrectPracticeAnswerHandler" do
          expect(factory.build)
          .to be_instance_of(IncorrectPracticeAnswerHandler)
        end
      end

      describe "when answer is correct" do
        let(:answer_is_correct) { true }

        it "returns a CorrectPracticeAnswerHandler" do
          expect(factory.build)
          .to be_instance_of(CorrectPracticeAnswerHandler)
        end
      end
    end

    describe "when guest" do
      describe "when answer is incorrect" do
        let(:answer_is_correct) { false }
        let(:user) { double(guest?: true) }

        it "returns an IncorrectPracticeAnswerHandler" do
          expect(factory.build)
          .to be_instance_of(IncorrectGuestAnswerHandler)
        end
      end

      describe "when answer is correct" do
        let(:answer_is_correct) { true }
        let(:user) { double(guest?: true) }

        it "returns a CorrectPracticeAnswerHandler" do
          expect(factory.build)
          .to be_instance_of(CorrectGuestAnswerHandler)
        end
      end
    end
  end
end

describe GameSession do
  let(:game_session) { GameSession.new(session) }
  describe "#initialize" do
    describe "when challenge" do
      let(:session) do
        {
          challenge_id: double,
          start_time: double,
          damage: double,
          streak: double
        }
      end

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
