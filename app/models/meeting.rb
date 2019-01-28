# == Schema Information
#
# Table name: meetings
#
#  id         :bigint(8)        not null, primary key
#  end_time   :datetime
#  start_time :datetime         not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :bigint(8)        not null
#
# Indexes
#
#  index_meetings_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#

class Meeting < ApplicationRecord
  belongs_to :club
  has_many :attendances, dependent: :destroy

  validates :start_time, presence: true
  validates_presence_of :club

  scope :future,  -> { where("start_time > ?", Date.current) }
  scope :past, -> { where("start_time <= ?", Date.current) }
end
