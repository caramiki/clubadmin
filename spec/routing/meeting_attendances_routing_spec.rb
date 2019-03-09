require "rails_helper"

RSpec.describe MeetingAttendancesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/clubs/1/meetings/1/attendances").to route_to(controller: "meeting_attendances", action: "index", club_id: "1", meeting_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/clubs/1/meetings/1/attendances").to route_to(controller: "meeting_attendances", action: "update", club_id: "1", meeting_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/clubs/1/meetings/1/attendances").to route_to(controller: "meeting_attendances", action: "update", club_id: "1", meeting_id: "1")
    end
  end
end
