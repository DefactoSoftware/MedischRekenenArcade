require 'spec_helper'

describe HeadToHeadChallenge do
  describe 'Associations' do
    it { should belong_to(:challenger) }
    it { should belong_to(:challenged) }
    it { should belong_to(:challenge) }
    it { should have_many(:user_challenges) }

  end

  describe 'Status' do
    it 'should start with open status' do
      head_to_head_challenge = FactoryGirl.create(:head_to_head_challenge)
      expect(head_to_head_challenge.status).to eq('open')
      expect(head_to_head_challenge.open?).to be(true)
    end
  end
end
