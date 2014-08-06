ActiveAdmin.register Answer do
  config.per_page = 50

  index do
    column "Answer" do |answer|
      answer.value
    end
    column "Result" do |answer|
      answer.problem.result
    end
    column "is correct?" do |answer|
      answer.correct? ? status_tag( "yes", :ok ) : status_tag( "no" )
    end
    column "Theory" do |answer|
      answer.problem.theory
    end
    column "User" do |answer|
      answer.user.guest? ? answer.user.username : link_to(answer.user.username, admin_user_path(answer.user))
    end
    column "Last updated" do |answer|
      answer.updated_at
    end
    column "Problem" do |answer|
      link_to("click", admin_problem_path(answer.problem))
    end
    column "UserChallenge" do |answer|
      answer.user_challenge ? link_to("click", admin_user_challenge_path(answer.user_challenge)) : "-"
    end
    actions
  end

  show do |answer|
    attributes_table do
      row :id
      row :value
      row :correct do
        answer.correct? ? status_tag( "yes", :ok ) : status_tag( "no" )
      end
      row :problem do
        table do
          tr do
            th "theory"
            th "result"
            th "difficulty"
            th "unit"
            th "link"
          end
          tr do
            td answer.problem.theory
            td answer.problem.result
            td answer.problem.difficulty
            td answer.problem.unit ? answer.problem.unit.sign : "-"
            td link_to("click", admin_problem_path(id: answer.problem.id))
          end
        end
      end
    end
    active_admin_comments
  end
end
