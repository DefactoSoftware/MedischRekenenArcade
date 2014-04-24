class RegistrationsController < Devise::RegistrationsController
  def new
    @default_user_group = UserGroup.where(name:"Overig").first || UserGroup.first
    super
  end

  def create
    super
  end

  def update
    super
  end
end
