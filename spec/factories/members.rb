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

FactoryBot.define do
  factory :member do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    notes { FFaker::Lorem.paragraph(rand(1..5)) }
    club_id { create(:club).id }

    trait :invalid do
      first_name { "" }
      last_name { "" }
    end
  end
end
