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

require 'rails_helper'

RSpec.describe Club, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
