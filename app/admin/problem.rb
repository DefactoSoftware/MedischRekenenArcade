ActiveAdmin.register Problem do
  show do |ad|
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
            th "details"
            th "value"
            th "user"
            th "correct"
          end
          problem.answers.each do |answer|
            tr do
              td link_to("click", admin_problem_answer_path(problem_id: problem.id, id: answer.id))
              td answer.value
              td link_to(answer.user.username, admin_user_path(answer.user))
              td problem.result == answer.value ? "True" : "False"
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
