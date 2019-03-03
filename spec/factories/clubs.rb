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

FactoryBot.define do
  factory :club do
    name { FFaker::Lorem.words(rand(1..5)).join(" ").titleize }
    description { FFaker::Lorem.paragraph(rand(1..5)) }
    creator_id { create(:user).id }

    trait :invalid do
      name { "" }
    end
  end
end
