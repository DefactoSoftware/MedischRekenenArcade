require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Answer" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { FactoryGirl.create(:user) }
  let(:token) { double(accessible?: true, resource_owner_id: user.id) }


  before :each do
    allow_any_instance_of(Api::V1::AnswersController).to receive(:doorkeeper_token) { token }
    allow_any_instance_of(Api::V1::BaseController).to receive(:current_user) { user }
  end

  post "/api/v1/answers" do
    let(:problem) { PercentageAmountOfAmount.new.generate(user) }

    parameter :problem_id, "The id of the problem that is being answered", scope: :answer
    parameter :unit_id, "The unit id of the unit of the problem", scope: :answer
    parameter :value, "The value of the answer", scope: :answer

    let(:problem_id) { problem.id }
    let(:unit_id) { problem.unit_id }
    let(:value) { rand(0..100).to_s }

    let(:raw_post) { params.to_json }

    example_request "Answer a problem" do
      expect(status).to eq(201)
    end
  end
end
