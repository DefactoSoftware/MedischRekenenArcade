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
      link_to(answer.user.username, admin_user_path(answer.user))
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
    default_actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :correct do
        ad.correct?
      end
      row :problem do
        table do
          tr do
            th "theory"
            th "result"
            th "link"
          end
          ad.problem do |problem|
            tr do
              td problem.theory
              td problem.result
              td link_to("click", admin_problem_path(id: problem.id))
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
