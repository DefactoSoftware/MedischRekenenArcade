module StatisticsHelper
  def challenge_stat_table(challenge, current_user)
    "<table class='table table-striped'>
      <tr>
        <th>#{t('challenges.labels.stats')}</th>
        <th>#{t('challenges.labels.amount')}</th>
      </tr>
      <tr>
        <td>#{t('challenges.labels.attempts')}</td>
        <td>#{challenge.user_challenges.where(user:current_user).count}</td>
      </tr>
      <tr>
        <td>#{t('challenges.labels.successfull')}</td>
        <td>#{challenge.total_success_for_user(current_user)}</td>
      </tr>
      <tr>
        <td>#{t('challenges.labels.failed')}</td>
        <td>#{challenge.total_failed_for_user(current_user)}</td>
      </tr>
    </table>"
  end

  def badge_popover(badge)
    badge_description = t("badges.#{badge.name}.description")
    "<p>#{badge_description}</p>"
  end
end
