# == Schema Information
#
# Table name: roles
#
#  id         :bigint(8)        not null, primary key
#  level      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :bigint(8)        not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_roles_on_club_id  (club_id)
#  index_roles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (user_id => users.id)
#

class Role < ApplicationRecord
  belongs_to :club, inverse_of: :roles
  belongs_to :user, inverse_of: :roles

  validates_presence_of :club
  validates_presence_of :user
  validates :club, uniqueness: { scope: :user }

  enum level: { organizer: 1, admin: 2 }

  after_create :create_member

  private

  # Make the user a member of the club
  def create_member
    Member.create!(
      user: user,
      first_name: user.first_name,
      last_name: user.last_name,
      club: club
    )
  end
end
