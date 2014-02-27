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
      set_rank level: 1, to: User do |user|
        user
      end

      set_rank level: 2, to: User do |user|
        user.points >= 50
      end

      set_rank level: 3, to: User do |user|
        user.points >= 100
      end

      set_rank level: 4, to: User do |user|
        user.points >= 200
      end

      set_rank level: 5, to: User do |user|
        user.points >= 300
      end

      set_rank level: 6, to: User do |user|
        user.points >= 450
      end

      set_rank level: 7, to: User do |user|
        user.points >= 600
      end

      set_rank level: 8, to: User do |user|
        user.points >= 750
      end

      set_rank level: 9, to: User do |user|
        user.points >= 1000
      end

      set_rank level: 10, to: User do |user|
        user.points >= 1500
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
