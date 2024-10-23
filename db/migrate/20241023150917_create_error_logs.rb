class CreateErrorLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :error_logs do |t|
      t.integer :code
      t.string :erro
      t.text :backtrace
      t.references :application, null: false, foreign_key: true
      t.string :url
      t.string :http_method
      t.datetime :date
      t.references :status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
