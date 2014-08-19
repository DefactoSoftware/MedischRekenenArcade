require "spec_helper"

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
