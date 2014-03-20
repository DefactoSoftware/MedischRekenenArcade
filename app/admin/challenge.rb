ActiveAdmin.register Challenge do

  index do
    column :id
    column :number_of_problems
    column :name do |challenge|
      I18n.t("challenges.#{challenge.name.underscore}.title")
    end
    column :timelimit
    column :bonus
    column :icon do |challenge|
      image_tag(challenge.icon, height: "50px")
    end
    default_actions
  end


  show do |challenge|
    attributes_table do
      row :id
      row :number_of_problems
      row :name do |challenge|
        I18n.t("challenges.#{challenge.name.underscore}.title")
      end

      row :user_challenges do
        table do
          tr do
            th "User"
            th "Success"
            th "Amount Good"
            th "Amount Fail"
            th "Date"
          end
          challenge.user_challenges.each do |user_challenge|
            tr do
              td link_to(user_challenge.user.username, admin_user_path(user_challenge.user))
              td user_challenge.success? ? status_tag( "yes", :ok ) : status_tag( "no" )
              td user_challenge.amount_good
              td user_challenge.amount_fail
              td user_challenge.updated_at
            end
          end
        end
      end
    end
    active_admin_comments
  end
end
