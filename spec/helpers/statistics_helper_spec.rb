require 'spec_helper'
describe StatisticsHelper do
  include StatisticsHelper

  let(:user) { FactoryGirl.create(:user) }
  let(:challenge) { FactoryGirl.create(:challenge) }
  2.times do
    let(:userchallenge) { FactoryGirl.create(:user_challenge, user: user.reload, challenge: challenge.reload) }
  end

  it "should return the correct table" do
    table = "<table class='table table-striped'>
      <tr>
        <th>Stats</th>
        <td></td>
      </tr>
      <tr>
        <td>Correct answered</td>
        <td>#{challenge.total_correct_answers_for_user(user)}</td>
      </tr>
      <tr>
        <td>Incorrect answered</td>
        <td>#{challenge.total_incorrect_answers_for_user(user)}</td>
      </tr>
      <tr>
        <td>Attempts</td>
        <td>#{challenge.user_challenges.where(user:user).count}</td>
      </tr>
      <tr>
        <td>Successful</td>
        <td>#{challenge.total_success_for_user(user)}</td>
      </tr>
      <tr>
        <td>Failed</td>
        <td>#{challenge.total_failed_for_user(user)}</td>
      </tr>
    </table>"
    expect(challenge_table(challenge, user)).to eq(table)
  end
end
