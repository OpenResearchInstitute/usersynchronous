class CreateLogFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :log_files do |t|
      t.references :loggable, polymorphic: true
      t.string     :log_file_name
      t.string     :log_content_type
      t.integer    :log_file_size
      t.datetime   :log_updated_at

      t.timestamps
    end
  end
end
