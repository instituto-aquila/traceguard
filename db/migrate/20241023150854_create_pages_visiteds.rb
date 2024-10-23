class CreatePagesVisiteds < ActiveRecord::Migration[7.2]
  def change
    create_table :pages_visiteds do |t|
      t.references :user_monitoring, null: false, foreign_key: true
      t.string :page_url
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration_seconds
      t.integer :publication_id
      t.string :publication_title

      t.timestamps
    end
  end
end
