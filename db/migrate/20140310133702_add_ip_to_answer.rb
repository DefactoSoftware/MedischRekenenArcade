class AddIpToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :ip, :string
  end
end
