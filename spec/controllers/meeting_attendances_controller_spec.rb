require "rails_helper"

RSpec.describe MeetingAttendancesController, type: :controller do
  let(:club) { create(:club) }
  let(:meeting) { create(:meeting, club: club) }
  let(:member) { create(:member, club: club) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { club_id: club.to_param, meeting_id: meeting.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested attendance list" do
        member1 = create(:member, club: club)
        attendance1 = create(:attendance, meeting: meeting, attendee: member1)
        member2 = create(:member, club: club)
        attendance2 = create(:attendance, meeting: meeting, attendee: member2)
        member3 = create(:member, club: club)

        expect(meeting.attendances.count).to eq(2)

        # Update an old attendance, destroy an old attendance, create a new attendance
        put :update, params: {
          club_id: club.to_param,
          meeting_id: meeting.to_param,
          meeting: {
            attendances_attributes: [
              { id: attendance1.id, arrival_time: DateTime.current },
              { id: attendance2.id, arrival_time: DateTime.current, _destroy: true },
              { id: nil, member_id: member.to_param },
            ]
          }
        }

        expect(meeting.attendances.count).to eq(2)
      end

      it "redirects to the meeting" do
        put :update, params: {
          club_id: club.to_param,
          meeting_id: meeting.to_param,
          meeting: {
            attendances_attributes: [ { member_id: member.to_param } ]
          }
        }

        expect(response).to redirect_to(club_meeting_attendances_url(club, meeting))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        invalid_attributes = attributes_for(:attendance, :invalid, meeting: meeting, attendee: member)

        put :update, params: {
          club_id: club.to_param,
          meeting_id: meeting.to_param,
          meeting: {
            attendances_attributes: [invalid_attributes]
          }
        }

        expect(response).to be_successful
      end
    end
  end
end
