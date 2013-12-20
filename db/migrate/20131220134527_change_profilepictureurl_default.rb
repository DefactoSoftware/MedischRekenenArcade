class ChangeProfilepictureurlDefault < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :profilepicture_url, :string, default: "/assets/no_profile.jpg"
    end
  end
end
