require 'spec_helper'


describe AnswersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:problem) { Problem.generate_random(2) }
  let(:badanswer) {FactoryGirl.attributes_for(:answer, problem_id: problem.id, value: problem.get_result + 1)}
  let(:goodanswer) {FactoryGirl.attributes_for(:answer, problem_id: problem.id, value: problem.get_result)}
  let(:skill) { FactoryGirl.create(:skill, name:"Addition") }
  let(:challenge) { FactoryGirl.create(:challenge) }
  let(:user_challenge) { FactoryGirl.create(:user_challenge, challenge: challenge, user: user) }

  before :each do
    @request.env['HTTP_REFERER'] = root_path
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
