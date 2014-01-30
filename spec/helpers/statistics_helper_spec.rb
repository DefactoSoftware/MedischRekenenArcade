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
        <th>#{t('challenges.labels.stats')}</th>
        <th>#{t('challenges.labels.amount')}</th>
      </tr>
      <tr>
        <td>#{t('challenges.labels.attempts')}</td>
        <td>0</td>
      </tr>
      <tr>
        <td>#{t('challenges.labels.successfull')}</td>
        <td>0</td>
      </tr>
      <tr>
        <td>#{t('challenges.labels.failed')}</td>
        <td>0</td>
      </tr>
    </table>"
    expect(challenge_stat_table(challenge, user)).to eq(table)
  end
end
