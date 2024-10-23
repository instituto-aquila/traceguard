class RenameMethodToHttpMethodInErrorLogs < ActiveRecord::Migration[7.2]
  def change
    rename_column :error_logs, :method, :http_method
  end
end
