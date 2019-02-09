# == Schema Information
#
# Table name: clubs
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :bigint(8)
#
# Indexes
#
#  index_clubs_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#

class Club < ApplicationRecord
  has_many :members, inverse_of: :club
  has_many :meetings, inverse_of: :club, dependent: :destroy
  has_many :roles, inverse_of: :club, dependent: :destroy
  has_many :users, through: :roles

  belongs_to :creator, foreign_key: "creator_id", class_name: "User"

  validates :name, presence: true

  after_create :create_admin

  def associated_with?(user)
    users.include? user
  end

  private

  def create_admin
    roles.create(user: creator, level: :admin) unless creator.super_admin?
  end
end
