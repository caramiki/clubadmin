require "rails_helper"

RSpec.describe MemberAttendancesController, type: :controller do
  let(:club) { create(:club) }
  let(:member) { create(:member, club: club) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { club_id: club.to_param, member_id: member.to_param }
      expect(response).to be_successful
    end
  end
end
