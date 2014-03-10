# Be sure to restart your server when you modify this file.
#
# +grant_on+ accepts:
# * Nothing (always grants)
# * A block which evaluates to boolean (recieves the object as parameter)
# * A block with a hash composed of methods to run on the target object with
#   expected values (+:votes => 5+ for instance).
#
# +grant_on+ can have a +:to+ method name, which called over the target object
# should retrieve the object to badge (could be +:user+, +:self+, +:follower+,
# etc). If it's not defined merit will apply the badge to the user who
# triggered the action (:action_user by default). If it's :itself, it badges
# the created object (new user for instance).
#
# The :temporary option indicates that if the condition doesn't hold but the
# badge is granted, then it's removed. It's false by default (badges are kept
# forever).

module Merit
  class BadgeRules
    MORNING_START = 5
    AFTERNOON_START = 11
    EVENING_START = 17
    NIGHT_START = 23

    include Merit::BadgeRulesMethods

    def initialize
      # If it has 10 comments, grant commenter-10 badge
      grant_on 'answers#create', badge: 'questions_answered_a', to: :user do |answer|
        answer.user && answer.user.answers.map.count == 10
      end

      grant_on 'answers#create', badge: 'questions_answered_b' do |answer|
        answer.user && answer.user.answers.count == 100
      end

      grant_on 'answers#create', badge: 'questions_answered_c' do |answer|
        answer.user && answer.user.answers.count == 1000
      end

      grant_on 'answers#create', badge: 'night_owl' do |answer|
        answer.user && answer.created_at.hour.between?(NIGHT_START, MORNING_START)
      end

      grant_on 'answers#create', badge: 'night_crawler' do |answer|
        answer.user && answer.created_at.hour.between?(EVENING_START, NIGHT_START)
      end

      grant_on 'answers#create', badge: 'rise_and_shine' do |answer|
        answer.user && answer.created_at.hour.between?(MORNING_START, AFTERNOON_START)
      end

      grant_on 'answers#create', badge: 'cold_feet_a' do |answer|
        answer.user && answer.user.answers.count == 10 && UserChallenge.where(user: answer.user).count == 0
      end

      grant_on 'answers#create', badge: 'cold_feet_b' do |answer|
        answer.user && answer.user.answers.count == 50 && UserChallenge.where(user: answer.user).count == 0
      end

      grant_on 'answers#create', badge: 'cold_feet_c' do |answer|
        answer.user && answer.user.answers.count == 100 && UserChallenge.where(user: answer.user).count == 0
      end

      # If it has 5 votes, grant relevant-commenter badge
      # grant_on 'comments#vote', :badge => 'relevant-commenter', :to => :user do |comment|
      #   comment.votes.count == 5
      # end

      # Changes his name by one wider than 4 chars (arbitrary ruby code case)
      # grant_on 'registrations#update', :badge => 'autobiographer', :temporary => true, :model_name => 'User' do |user|
      #   user.name.length > 4
      # end
    end
  end
end
