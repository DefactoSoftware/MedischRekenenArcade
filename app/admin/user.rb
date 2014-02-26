ActiveAdmin.register User do
  index do
    column :id
    column :email
    column :level
    column :last_sign_in_at
    column :name
    column :confirmed_at
    default_actions
  end

  show do |user|
    attributes_table do
      row :id
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :username
      row :name
      row :level
      row :user_group
    end

    attributes_table do
      table do
        tr do
          th "Skill"
          th "Level"
        end
        user.user_skills.order("LEVEL DESC").each do |user_skill|
          tr do
            td link_to user_skill.skill.name, admin_challenge_path(challenge: Challenge.where(name:user_skill.skill.name).first)
            td user_skill.level
          end
        end
      end
    end

    attributes_table do
      table do
        tr do
          th "Success"
          th "Amount fail"
          th "Amount good"
          th "Challenge"
        end
        user.user_challenges.limit(50).each do |user_challenge|
          tr do
            td user_challenge.success ? status_tag( "yes", :ok ) : status_tag( "no" )
            td user_challenge.amount_fail
            td user_challenge.amount_good
            td link_to "click", admin_challenge_path(user_challenge.challenge)
          end
        end
      end
    end

    attributes_table do
      table do
        tr do
          th "value"
          th "correct answer"
          th "theory"
          th "difficulty"
          th "correct"
        end
        user.answers.limit(50).each do |answer|
          tr do
            td answer.value
            td answer.problem.result
            td answer.problem.theory
            td answer.problem.difficulty
            td answer.correct? ? status_tag( "yes", :ok ) : status_tag( "no" )
          end
        end
      end
    end

    active_admin_comments
  end
end
