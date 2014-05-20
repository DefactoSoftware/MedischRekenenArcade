require 'spec_helper'

describe AnswersController, type: :controller do
  include Devise::TestHelpers
  let(:user) { FactoryGirl.create(:user) }
  let(:problem) { PercentageAmountOfAmount.new.generate(user) }
  let(:goodanswer) {FactoryGirl.attributes_for(:answer, problem_id: problem.id, user: user, value: problem.get_result)}

  before :each do
    sign_in user.reload
  end

  it "grants the questions_answered_a badge" do
    9.times do
      Answer.create(user:user)
    end
    post :create, answer: goodanswer
    expect(user.reload.badges).to include(Merit::Badge.find(8))
  end

  it "grants the questions_answered_b badge" do
    99.times do
      Answer.create(user:user)
    end
    post :create, answer: goodanswer
    expect(user.reload.badges).to include(Merit::Badge.find(9))
  end

  it "grants the questions_answered_c badge" do
    999.times do
      Answer.create(user:user)
    end
    post :create, answer: goodanswer
    expect(user.reload.badges).to include(Merit::Badge.find(10))
  end
end

describe User do
  let(:user) { FactoryGirl.create(:user) }
  it "grants the particioner badge" do
    expect(user.badges).to include(Merit::Badge.find(24))
  end

  it "grants the narcissist badge on signup" do
    user = FactoryGirl.create(:user, profilepicture_url: "test.jpg")
    expect(user.badges).to include(Merit::Badge.find(25))
  end

  it "grants the narcissist badge on update" do
    user.reload.update_attributes(profilepicture_url: "test.jpg")
    expect(user.badges).to include(Merit::Badge.find(25))
  end
end

describe AnswerHandler do
  let(:user) { FactoryGirl.create(:user) }
  let(:session) { {} }
  it "grants the streakmaster a badge on a streak of 10 good answers" do
    session[:streak] = 10
    AnswerHandler.new(session, user.reload, double).check_badges
    expect(user.badges).to include(Merit::Badge.find(5))
  end

  it "grants the streakmaster b badge on a streak of 100 good answers" do
    session[:streak] = 50
    AnswerHandler.new(session, user.reload, double).check_badges
    expect(user.badges).to include(Merit::Badge.find(6))
  end

  it "grants the streakmaster a badge on a streak of 1000 good answers" do
    session[:streak] = 100
    AnswerHandler.new(session, user.reload, double).check_badges
    expect(user.badges).to include(Merit::Badge.find(7))
  end
end
