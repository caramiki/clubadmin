require "rails_helper"

RSpec.describe MembersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/clubs/1/members").to route_to(controller: "members", action: "index", club_id: "1")
    end

    it "routes to #new" do
      expect(get: "/clubs/1/members/new").to route_to(controller: "members", action: "new", club_id: "1")
    end

    it "routes to #show" do
      expect(get: "/clubs/1/members/1").to route_to(controller: "members", action: "show", club_id: "1", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/clubs/1/members/1/edit").to route_to(controller: "members", action: "edit", club_id: "1", id: "1")
    end

    it "routes to #create" do
      expect(post: "/clubs/1/members").to route_to(controller: "members", action: "create", club_id: "1")
    end

    it "routes to #update via PUT" do
      expect(put: "/clubs/1/members/1").to route_to(controller: "members", action: "update", club_id: "1", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/clubs/1/members/1").to route_to(controller: "members", action: "update", club_id: "1", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/clubs/1/members/1").to route_to(controller: "members", action: "destroy", club_id: "1", id: "1")
    end
  end
end
