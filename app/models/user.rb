# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  super_admin            :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :roles, inverse_of: :user
  has_many :clubs, through: :roles
  has_many :memberships, inverse_of: :user, foreign_key: "user_id", class_name: "Member"

  after_update :update_memberships

  def admin_of?(club)
    super_admin? || role_in(club)&.admin?
  end

  def associated_with?(obj)
    if obj.respond_to?(:associated_with?)
      return(self.super_admin? || obj.associated_with?(self))
    else
      raise ArgumentError, "Argument must respond to :associated_with? in order to check associations"
    end
  end

  def membership(club)
    memberships.where(club: club).first
  end

  def role_in(club)
    roles.find_by_club_id(club.id)
  end

  private

  def update_memberships
    memberships.each do |membership|
      membership.update!(
        first_name: first_name,
        last_name: last_name
      )
    end
  end
end
