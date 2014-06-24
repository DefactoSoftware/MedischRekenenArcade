module Api
  module V1
    module Tincan
      class UserChallengesController < BaseController
        def index
          render json: requested_user.user_challenges,
                 each_serializer: TinCanUserChallengeSerializer,
                 status: :ok
        end

        private

        def user_challenge_parameters
          params.permit(:user_id)
        end

        def requested_user
          user_from_parameters || current_user
        end

        def user_from_parameters
          if user_challenge_parameters[:user_id]
            User.find(user_challenge_parameters[:user_id])
          end
        end
      end
    end
  end
end
