class AddApiKeyToApplications < ActiveRecord::Migration[7.2]
  def change
    add_column :applications, :api_key, :string
    add_index :applications, :api_key, unique: true
  end
end
