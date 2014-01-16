# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongo_mapper and :mongoid
  config.orm = :active_record

  # Define :user_model_name. This model will be used to grand badge if no :to option is given. Default is "User".
  config.user_model_name = "User"

  # Define :current_user_method. Similar to previous option. It will be used to retrieve :user_model_name object if no :to option is given. Default is "current_#{user_model_name.downcase}".
  config.current_user_method = "current_user"
end

include ActionView::Helpers::AssetTagHelper

# Create application badges (uses https://github.com/norman/ambry)
Merit::Badge.create!(
  {
    id: 1,
    name: 'just_registered',
    image: asset_path("assets/no_image.png"),
    description: I18n.t('badges.just_registered.description')
  }
)
Merit::Badge.create!(
  {
    id: 2,
    name: 'answered_10',
    image: asset_path("assets/no_image.png"),
    description: "You have answered 10 questions or more!"
  }
)
Merit::Badge.create!(
  {
    id: 3,
    name: 'completed_first_challenge_successfully',
    image: asset_path("assets/no_image.png"),
    description: "You have successfully completed your first challenge!"
  }
)
Merit::Badge.create!(
  {
    id: 4,
    name: 'completed_ten_challenges_successfully',
    image: asset_path("assets/no_image.png"),
    description: "You have successfully completed 10 challenges!"
  }
)
