module Api
  module V1
    class BaseController < ApplicationController
      skip_before_filter :verify_authenticity_token
      doorkeeper_for :all
      respond_to :json

      private

      def current_user
        if doorkeeper_token
          @current_user ||= User.find(doorkeeper_token.resource_owner_id)
        end
      end
    end
  end
end
