# == Schema Information
#
# Table name: clubs
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  name        :string           not null
#  timezone    :string           default("Etc/UTC"), not null
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
  extend TimezoneOptions

  has_many :members, inverse_of: :club, dependent: :destroy
  has_many :meetings, inverse_of: :club, dependent: :destroy
  has_many :roles, inverse_of: :club, dependent: :destroy
  has_many :users, through: :roles

  belongs_to :creator, foreign_key: "creator_id", class_name: "User"

  validates :name, presence: true
  validates_inclusion_of :timezone, in: timezone_names

  after_create :create_admin_role_for_creator

  def associated_with?(user)
    users.include? user
  end

  private

  def create_admin_role_for_creator
    roles.create(user: creator, level: :admin) unless creator.super_admin?
  end
end
