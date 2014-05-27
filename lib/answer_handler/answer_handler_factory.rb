class AnswerHandlerFactory
  def initialize(session, answer_is_correct, user, skill, user_challenge=nil)
    @session = session
    @answer_is_correct = answer_is_correct
    @user = user
    @skill = skill
    @user_challenge = user_challenge
  end

  def build
    if @user.guest?
      if @answer_is_correct
        CorrectGuestAnswerHandler.new(@session, @user, @skill)
      else
        IncorrectGuestAnswerHandler.new(@session, @user, @skill)
      end
    elsif @session[:challenge]
      if !@user_challenge.head_to_head_challenge
        if @answer_is_correct
          CorrectChallengeAnswerHandler.new(@session, @user, @user_challenge, @skill)
        else
          IncorrectChallengeAnswerHandler.new(@session, @user, @user_challenge, @skill)
        end
      else
        if @answer_is_correct
          CorrectHeadToHeadChallengeAnswerHandler.new(@session, @user, @user_challenge, @skill)
        else
          IncorrectHeadToHeadChallengeAnswerHandler.new(@session, @user, @user_challenge, @skill)
        end
      end
    else
      if @answer_is_correct
        CorrectPracticeAnswerHandler.new(@session, @user, @skill)
      else
        IncorrectPracticeAnswerHandler.new(@session, @user, @skill)
      end
    end
  end
end
