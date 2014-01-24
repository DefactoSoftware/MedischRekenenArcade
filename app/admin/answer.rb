ActiveAdmin.register Answer do
  belongs_to :problem

  filter :user
  filter :created_at
  filter :updated_at
end
