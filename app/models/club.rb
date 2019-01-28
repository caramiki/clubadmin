# == Schema Information
#
# Table name: clubs
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Club < ApplicationRecord
  has_many :members
  has_many :meetings, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :name, presence: true
end
