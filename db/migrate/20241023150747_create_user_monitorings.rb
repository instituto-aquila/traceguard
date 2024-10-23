class CreateUserMonitorings < ActiveRecord::Migration[7.2]
  def change
    create_table :user_monitorings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :application, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
