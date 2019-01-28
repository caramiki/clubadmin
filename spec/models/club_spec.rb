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

require 'rails_helper'

RSpec.describe Club, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
