module StatisticsHelper
  def challenge_table(challenge, current_user)
    "<table class='table table-striped'>
      <tr>
        <th>Stats</th>
        <td></td>
      </tr>
      <tr>
        <td>Correct answered</td>
        <td>#{challenge.total_correct_answers_for_user(current_user)}</td>
      </tr>
      <tr>
        <td>Incorrect answered</td>
        <td>#{challenge.total_incorrect_answers_for_user(current_user)}</td>
      </tr>
      <tr>
        <td>Attempts</td>
        <td>#{challenge.user_challenges.where(user:current_user).count}</td>
      </tr>
      <tr>
        <td>Successful</td>
        <td>#{challenge.total_success_for_user(current_user)}</td>
      </tr>
      <tr>
        <td>Failed</td>
        <td>#{challenge.total_failed_for_user(current_user)}</td>
      </tr>
    </table>"
  end
end
