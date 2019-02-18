# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  end_time    :datetime
#  notes       :text
#  start_time  :datetime         not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  club_id     :bigint(8)        not null
#
# Indexes
#
#  index_meetings_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#

require 'rails_helper'

RSpec.describe Meeting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
