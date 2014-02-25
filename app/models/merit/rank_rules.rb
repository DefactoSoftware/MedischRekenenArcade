# Be sure to restart your server when you modify this file.
#
# 5 stars is a common ranking use case. They are not given at specified
# actions like badges, you should define a cron job to test if ranks are to be
# granted.
#
# +set_rank+ accepts:
# * :+level+ ranking level (greater is better)
# * :+to+ model or scope to check if new rankings apply
# * :+level_name+ attribute name (default is empty and results in 'level'
#   attribute, if set it's appended like 'level_#{level_name}')

module Merit
  class RankRules
    include Merit::RankRulesMethods

    def initialize
      set_rank level: 1, level_name: "First Aid Volunteer", to: User do |user|
        user.points >= 25
      end

      set_rank level: 2, level_name: "Paramedic", to: User do |user|
        user.points >= 50
      end

      set_rank level: 3, level_name: "Nursery Assistent", to: User do |user|
        user.points >= 75
      end

      set_rank level: 4, level_name: "Anaesthetist", to: User do |user|
        user.points >= 100
      end

      set_rank level: 5, level_name: "Nurse Practicioner", to: User do |user|
        user.points >= 150
      end

      set_rank level: 6, level_name: "Clinical Nurse Specialist" to: User do |user|
        user.points >= 200
      end

      set_rank level: 7, level_name: "Head of Nursery" to: User do |user|
        user.points >= 350
      end

      set_rank level: 8, level_name: "Brain Surgeon" to: User do |user|
        user.points >= 500
      end

      set_rank level: 9, level_name: "Head of Surgery" to: User do |user|
        user.points >= 700
      end

      set_rank level: 10, level_name: "Surgeon General" to: User do |user|
        user.points >= 1000
      end

      #   commiter.repositories.count > 1 && commiter.followers >= 10
      # end
      #
      # set_rank :level => 2, :to => Commiter.active do |commiter|
      #   commiter.branches.count > 1 && commiter.followers >= 10
      # end
      #
      # set_rank :level => 3, :to => Commiter.active do |commiter|
      #   commiter.branches.count > 2 && commiter.followers >= 20
      # end
    end
  end
end
