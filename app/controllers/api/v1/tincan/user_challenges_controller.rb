module Api
  module V1
    module Tincan
      class UserChallengesController < BaseController
        def index
          if user_challenge_parameters[:user_id]
            @user_challenges = User.find(user_challenge_parameters[:user_id]).user_challenges
          else
            @user_challenges = current_user.user_challenges
          end

          if @user_challenges
            render json: @user_challenges, each_serializer: TinCanUserChallengeSerializer, status: :ok
          end
        end

        private
        def user_challenge_parameters
          params.permit(:user_id)
        end
      end
    end
  end
end
