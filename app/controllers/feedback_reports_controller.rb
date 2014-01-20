class FeedbackReportsController < ApplicationController
  def create
    @feedback_report = FeedbackReport.new(feedback_report_parameters)
    @feedback_report.user = current_user
    @feedback_report.page = request.referer

    if @feedback_report.save!
      redirect_to request.referer, notice: t("feedback_report.save.success")
    else
      redirect_to request.referer, error: t("feedback_report.save.error")
    end
  end

  private
  def feedback_report_parameters
    params.require(:feedback_report).permit(:text, :subject, :page)
  end
end
