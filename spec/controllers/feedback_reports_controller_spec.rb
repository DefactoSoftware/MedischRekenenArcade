require 'spec_helper'

describe FeedbackReportsController do
  describe "POST create feedback report" do
    let(:user) { FactoryGirl.create(:user) }
    let(:feedback_report_attributes) { FactoryGirl.attributes_for(:feedback_report) }

    it "creates a report" do
      @request.env['HTTP_REFERER'] = root_path
      sign_in user
      post :create, feedback_report: feedback_report_attributes
      expect(FeedbackReport.last.text).to eq(feedback_report_attributes[:text])
    end
  end
end
