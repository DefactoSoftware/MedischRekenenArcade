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

  describe 'Notifying users' do
    it 'should create notifications for both users after create' do
      head_to_head_challenge = FactoryGirl.create(:head_to_head_challenge)
      challenger_notification = head_to_head_challenge.challenger.notifications.last
      challenged_notification = head_to_head_challenge.challenged.notifications.last
      expect(challenger_notification.text).to eq(I18n.t('notifications.head_to_head_challenge.challenger.text'))
      expect(challenged_notification.text).to eq(I18n.t('notifications.head_to_head_challenge.challenged.text'))
      expect(challenger_notification.title).to eq(I18n.t('notifications.head_to_head_challenge.challenger.title',
                                                          name: head_to_head_challenge.challenged.name))
      expect(challenged_notification.title).to eq(I18n.t('notifications.head_to_head_challenge.challenged.title',
                                                          name: head_to_head_challenge.challenger.name))
    end
  end
end
