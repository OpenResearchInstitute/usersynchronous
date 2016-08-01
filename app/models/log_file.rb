# == Schema Information
#
# Table name: log_files
#
#  id               :integer          not null, primary key
#  loggable_type    :string
#  loggable_id      :integer
#  log_file_name    :string
#  log_content_type :string
#  log_file_size    :integer
#  log_updated_at   :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_log_files_on_loggable_type_and_loggable_id  (loggable_type,loggable_id)
#

class LogFile < ApplicationRecord
  belongs_to :loggable, polymorphic: true

  has_attached_file :log

  validates :log, attachment_presence: true

  validates_attachment_content_type :log, content_type: 'text/plain'
end
