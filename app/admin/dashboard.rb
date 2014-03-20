ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Recent Answers" do
          table do
            thead do
              th "Answer"
              th "Result"
              th "User"
              th "Correct"
              th "Problem"
              th "Theory"
            end
            Answer.find(:all, :order => "id desc", :limit => 100).map do |answer|
              tr do
                td answer.value
                td answer.problem.result
                td link_to(answer.user.username, admin_user_path(answer.user))
                td answer.correct? ? status_tag( "yes", :ok ) : status_tag( "no" )
                td link_to("click", admin_problem_path(answer.problem))
                td answer.problem.theory
              end
            end
          end
        end
      end
      column do
        panel "Recent User Challenges" do
          table do
            thead do
              th "Challenge"
              th "User"
              th "Success"
              th "Challenge"
            end
            UserChallenge.find(:all, :order => "id desc", :limit => 100).map do |challenge|
              tr do
                td t("challenges.#{challenge.challenge.name.underscore}.title")
                td link_to(challenge.user.username, admin_user_path(challenge.user))
                td challenge.success? ? "True" : "False"
                td link_to "click", admin_user_challenge_path(challenge)
              end
            end
          end
        end
      end
    end
    columns do
      column do
        panel "Recent Activities" do
          table do
            thead do
              th "User"
              th "Action"
              th "Trackable"
              th "TrackableID"
            end
            Activity.find(:all, :order => "id desc", :limit => 100).map do |activity|
              tr do
                td link_to(activity.user.username, admin_user_path(activity.user))
                td activity.action
                td activity.trackable_type
                td activity.trackable.id
              end
            end
          end
        end
      end
    end
  end
end
