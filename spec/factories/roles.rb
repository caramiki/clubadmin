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

FactoryBot.define do
  factory :role do
    club { create(:club) }
    user { create(:user) }
    level { :admin }

    trait :organizer do
      level { :organizer }
    end

    trait :admin do
      level { :admin }
    end
  end
end
