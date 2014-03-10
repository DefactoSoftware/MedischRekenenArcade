class AnswerHandlerFactory
  def initialize(session, answer_is_correct, user, skill)
    @session = session
    @answer_is_correct = answer_is_correct
    @user = user
    @skill = skill
  end

  def build
    if @user.guest?
      if @answer_is_correct
        CorrectGuestAnswerHandler.new(@session, @user, @skill)
      else
        IncorrectGuestAnswerHandler.new(@session, @user, @skill)
      end
    elsif @session[:challenge]
      if @answer_is_correct
        CorrectChallengeAnswerHandler.new(@session, @user, user_challenge, @skill)
      else
        IncorrectChallengeAnswerHandler.new(@session, @user, user_challenge, @skill)
      end
    else
      if @answer_is_correct
        CorrectPracticeAnswerHandler.new(@session, @user, @skill)
      else
        IncorrectPracticeAnswerHandler.new(@session, @user, @skill)
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
