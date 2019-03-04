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

require "rails_helper"

RSpec.describe Role, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
