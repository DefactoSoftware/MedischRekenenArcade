require "spec_helper"

describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:problem) { PercentageAmountOfAmount.new.generate(user) }
  let(:challenge) { create(:challenge) }
  let(:user_challenge) do
    create(:user_challenge, challenge: challenge, user: user)
  end
  let(:badanswer) do
    attributes_for(:answer,
                   problem_id: problem.id,
                   value: problem.get_result + 1,
                   user_challenge_id: user_challenge.id)
  end
  let(:goodanswer) do
    attributes_for(:answer,
                   problem_id: problem.id,
                   value: problem.get_result,
                   user_challenge_id: user_challenge.id)
  end
  let(:conversion_error_answer) do
    attributes_for(:answer,
                   problem_id: problem.id,
                   value: problem.get_result * 1000)
  end
  let(:rounding_error_answer) do
    attributes_for(:answer,
                   problem_id: problem.id,
                   value: problem.get_result - Float(0.1).round(2))
  end
  let(:skill) { create(:skill, name: "Addition") }

  before :each do
    @request.env["HTTP_REFERER"] = root_path
    skill.reload
    problem.reload
    sign_in user.reload
  end

  describe "POST create bad answer" do
    it "redirects the user" do
      post :create, answer: badanswer
      expect(response.status).to eq(302)
    end

    it "resets streak on bad answer" do
      post :create, answer: badanswer
      expect(session[:streak]).to be(0)
    end

    it "no damage with no challenge" do
      post :create, answer: goodanswer
      expect(session[:damage]).to eq(nil)
    end

    it "score does not go up on bad answer" do
      expect {
        post :create, answer: badanswer
      }.to change(user, :points).by(0)
    end

    describe "#feedback" do
      it "has rounding error answer feedback " do
        post :create, answer: rounding_error_answer
        expect(Answer.last.feedback).to eq(I18n.t("answer.feedback.rounding2"))
      end

      it "has conversion error answer feedback " do
        post :create, answer: conversion_error_answer
        expect(Answer.last.feedback).to eq(I18n.t("answer.feedback.conversion"))
      end

      it "has perfect feedback" do
        post :create, answer: goodanswer
        expect(Answer.last.feedback).to eq(I18n.t("answer.feedback.correct"))
      end
    end
  end

  describe "POST create good answer" do
    it "redirects the user" do
      post :create, answer: goodanswer
      expect(response.status).to eq(302)
    end

    it "increases streak on good answer" do
      post :create, answer: goodanswer
      expect(session[:streak]).to be(1)
    end

    it "no damage on good answer" do
      post :create, answer: goodanswer
      expect(session[:damage]).to eq(nil)
    end

    it "score goes up on good answer" do
      post :create, answer: goodanswer
      expect(user.reload.points).to be(1)
    end
  end

  describe "POST create good answer in challenge" do
    before :each do
      session[:challenge] = challenge.id
      user_challenge.reload
    end

    it "increases streak on good answer" do
      post :create, answer: goodanswer
      expect(session[:streak]).to be(1)
    end

    it "no damage on good answer" do
      post :create, answer: goodanswer
      expect(session[:damage]).to eq(nil)
    end

    it "score goes up on good answer" do
      post :create, answer: goodanswer
      expect(user.reload.points).to be(1)
    end
  end

  describe "POST create bad answer in challenge" do
    before :each do
      session[:challenge] = challenge.id
      user_challenge.reload
    end

    it "does not increase streak" do
      post :create, answer: badanswer
      expect(session[:streak]).to be(0)
    end

    it "increase damage" do
      post :create, answer: badanswer
      expect(session[:damage]).to eq(1)
    end

    it "score does not go up" do
      post :create, answer: badanswer
      expect(user.points).to be(0)
    end
  end

end
