ActiveAdmin.register User do
  show do |ad|
    attributes_table do
      row :id
      row :email
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :username
      row :name
      row :user_group
    end

    puts ad.user_skills

    attributes_table do
      table do
        tr do
          th "Skill"
          th "Level"
        end
        ad.user_skills.order("LEVEL DESC").each do |user_skill|
          tr do
            td link_to user_skill.skill.name, admin_challenge_path(challenge: Challenge.where(name:user_skill.skill.name).first)
            td user_skill.level
          end
        end
      end
    end
    active_admin_comments
  end
end
