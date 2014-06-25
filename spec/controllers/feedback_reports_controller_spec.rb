require "spec_helper"

describe FeedbackReportsController, type: :controller do
  describe "POST create feedback report" do
    let(:user) { create(:user) }
    let(:feedback_report_attributes) { attributes_for(:feedback_report) }

    before :each do
      @request.env["HTTP_REFERER"] = root_path
      sign_in user
      post :create, feedback_report: feedback_report_attributes
    end

    it "creates a report with text" do
      expect(FeedbackReport.last.text)
      .to eq(feedback_report_attributes[:text])
    end

    it "creates a report with subject" do
      expect(FeedbackReport.last.subject)
      .to eq(feedback_report_attributes[:subject])
    end

    it "creates a report with page equal to request referer" do
      expect(FeedbackReport.last.page).to eq(root_path)
    end
  end
end
