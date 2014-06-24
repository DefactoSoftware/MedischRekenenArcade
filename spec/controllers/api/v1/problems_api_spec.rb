require "spec_helper"
require "rspec_api_documentation/dsl"

resource "Problem" do
  header "Accept", "application/json"
  header "Content-Type", "application/json"

  let(:user) { create(:user) }
  let(:token) { double(accessible?: true, resource_owner_id: user.id) }
  let(:problem) { Problem::VALID_PROBLEMS.sample }

  before :each do
    allow_any_instance_of(Api::V1::ProblemsController).
      to receive(:doorkeeper_token) { token }
  end

  get "/api/v1/problems" do
    example_request "Generate a problem" do
      expect(status).to eq(201)
    end
  end

  get "/api/v1/problems?problem=:problem" do
    example_request "Generate a specific problem" do
      expect(status).to eq(201)
    end
  end
end
