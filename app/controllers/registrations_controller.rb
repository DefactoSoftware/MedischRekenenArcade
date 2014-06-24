class RegistrationsController < Devise::RegistrationsController
  def new
    @default_user_group = default_user_group
    super
  end

  def create
    @default_user_group = default_user_group
    super
  end

  def update
    super
  end

  private

  def default_user_group
    UserGroup.where(name: "Overig").first || UserGroup.first
  end
end
