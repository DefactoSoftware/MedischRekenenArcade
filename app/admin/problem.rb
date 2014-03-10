ActiveAdmin.register Problem do
  show do |problem|
    attributes_table do
      row :id
      row :theory
      row :difficulty
      row :created_at
      row :updated_at
      row :result
      row :unit
      row :answers do
        table do
          tr do
            th "value"
            th "user"
            th "correct"
          end
          problem.answers.each do |answer|
            tr do
              td answer.value
              td answer.user.guest? ? answer.user.username : link_to(answer.user.username, admin_user_path(answer.user))
              td answer.correct? ? status_tag( "yes", :ok ) : status_tag( "no" )
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
