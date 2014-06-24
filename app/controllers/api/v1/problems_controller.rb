module Api
  module V1
    class ProblemsController < BaseController
      def index
        problem_name = params[:problem] || "Mixed"
        problem = ProblemFactory.new(problem_name, current_user).problem
        render json: problem,
               status: :created,
               serializer: ProblemSerializer
      end
    end
  end
end
