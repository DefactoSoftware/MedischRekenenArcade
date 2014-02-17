module Api
  module V1
    class ProblemsController < BaseController
      def index
        render json: ProblemFactory.new(params[:problem] || "Mixed", current_user).problem, status: :created
      end
    end
  end
end
