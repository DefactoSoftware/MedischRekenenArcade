ActiveAdmin.register UserChallenge do
  config.per_page = 50

  index do
    column :id
    column :success
    column :amount_fail
    column :amount_good
    column :challenge do |user_challenge|
      link_to "click", admin_challenge_path(user_challenge.challenge)
    end
    default_actions
  end
end
