require "rails_helper"

RSpec.describe MemberAttendancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/clubs/1/members/1/attendances").to route_to(controller: "member_attendances", action: "index", club_id: "1", member_id: "1")
    end
  end
end
