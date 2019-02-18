# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  end_time    :datetime
#  notes       :text
#  start_time  :datetime         not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  club_id     :bigint(8)        not null
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
  include DateAndTimeFormattable

  belongs_to :club, inverse_of: :meetings
  has_many :attendances, inverse_of: :meeting, dependent: :destroy
  has_many :attendees, class_name: "Member", through: :attendances

  validates :start_time, presence: true
  validate :end_time_after_start_time
  validates :club, presence: true

  scope :future, -> { where("start_time > ?", Date.current) }
  scope :past, -> { where("start_time <= ?", Date.current) }

  def associated_with?(user)
    club.users.include? user
  end

  def date
    date_format(start_time)
  end

  def date_and_time
    return start_time_display unless end_time.present?

    date_and_time_range_format(start_time, end_time)
  end

  def end_time_display
    date_and_time_format(end_time) if end_time.present?
  end

  def start_time_display
    date_and_time_format(start_time)
  end

  def title_display
    if title.present?
      title
    else
      "#{date} #{Meeting.name}"
    end
  end

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    errors.add(:end_time, :after_start_time) if end_time <= start_time
  end
end
