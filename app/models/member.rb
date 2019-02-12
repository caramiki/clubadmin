# == Schema Information
#
# Table name: members
#
#  id         :bigint(8)        not null, primary key
#  first_name :string
#  last_name  :string
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :bigint(8)        not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_members_on_club_id  (club_id)
#  index_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (user_id => users.id)
#

class Member < ApplicationRecord
  belongs_to :club, inverse_of: :members
  belongs_to :user, inverse_of: :memberships, required: false
  has_many :attendances, inverse_of: :member, dependent: :destroy

  # We need at least a first name or a last name
  validates :first_name, presence: { if: -> { last_name.blank? } }
  validates :last_name, presence: { if: -> { first_name.blank? } }

  validates :club, presence: true
  validates :club, uniqueness: { scope: :user }

  def associated_with?(user)
    club.users.include? user
  end

  def attendance(meeting)
    attendances.where(meeting: meeting).first
  end

  def attended?(meeting)
    attendance(meeting).present?
  end
end
