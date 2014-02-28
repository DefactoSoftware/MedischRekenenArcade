class AddTitleToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :title, :string, default: "Notification"
  end
end
