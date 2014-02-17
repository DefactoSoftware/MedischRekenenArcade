module Api
  module V1
    class ProblemsController < BaseController
      def index
        respond_with ProblemSerializer.new(ProblemFactory.new(params[:problem] || "Mixed", current_user).problem).to_json, status: :created
      end
    end
  end
end
