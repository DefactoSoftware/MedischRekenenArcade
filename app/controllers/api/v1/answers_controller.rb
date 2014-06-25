module Api
  module V1
    require "answer_handler"
    class AnswersController < BaseController
      def create
        @answer = Answer.new(value: parse_value(answer_parameters[:value]),
                             problem_id: answer_parameters[:problem_id],
                             user: current_user)

        handler = AnswerHandlerFactory.new(session,
                                           @answer.correct?,
                                           current_user,
                                           @answer.problem.skill).build
        handler.handle!

        if @answer.save
          render json: @answer, status: :created
        end
      end

      private

      def answer_parameters
        params.require(:answer).permit(:value, :unit_id, :problem_id)
      end

      def parse_value(value)
        value.gsub(",", ".")
      end
    end
  end
end
