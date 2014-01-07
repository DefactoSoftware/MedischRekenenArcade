class AnswerHandlerFactory
  def initialize(session, answer_is_correct, user)
    @session = session
    @answer_is_correct = answer_is_correct
    @user = user
  end

  def build
    if @session[:challenge]
      if @answer_is_correct
        CorrectChallengeAnswerHandler.new(@session, @user, user_challenge)
      else
        IncorrectChallengeAnswerHandler.new(@session, @user, user_challenge)
      end
    else
      if @answer_is_correct
        CorrectPracticeAnswerHandler.new(@session, @user)
      else
        IncorrectPracticeAnswerHandler.new(@session, @user)
      end
    end
  end

  private
  def user_challenge
    UserChallenge.where(
      challenge: Challenge.find(@session[:challenge]), user: @user
    ).last
  end
end
