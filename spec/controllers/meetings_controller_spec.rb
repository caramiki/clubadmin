require "rails_helper"

RSpec.describe MeetingsController, type: :controller do
  let(:valid_attributes) { attributes_for(:meeting) }
  let(:invalid_attributes) { attributes_for(:meeting, :invalid) }
  let(:club) { create(:club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: { club_id: club.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      meeting = create(:meeting, club: club)
      get :show, params: { club_id: club.to_param, id: meeting.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { club_id: club.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      meeting = create(:meeting, club: club)
      get :edit, params: { club_id: club.to_param, id: meeting.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Meeting" do
        club.meetings.reload
        expect {
          post :create, params: { club_id: club.to_param, meeting: valid_attributes }
        }.to change(club.meetings, :count).by(1)
      end

      it "redirects to the created club" do
        post :create, params: { club_id: club.to_param, meeting: valid_attributes }
        expect(response).to redirect_to(club_meeting_url(club, Meeting.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { club_id: club.to_param, meeting: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    let(:meeting) { create(:meeting, club: club) }

    context "with valid params" do
      let(:new_start_time) { meeting.start_time - 1.hour }
      
      it "updates the requested meeting" do
        put :update, params: {
          club_id: club.to_param, id: meeting.to_param, meeting: { start_time: new_start_time }
        }
        meeting.reload
        expect(meeting.start_time).to eq(new_start_time)
      end

      it "redirects to the meeting" do
        put :update, params: {
          club_id: club.to_param, id: meeting.to_param, meeting: { start_time: new_start_time }
        }
        expect(response).to redirect_to(club_meeting_url(club, meeting))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          club_id: club.to_param, id: meeting.to_param, meeting: invalid_attributes
        }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    let(:meeting) { create(:meeting, club: club) }

    it "destroys the requested meeting" do
      meeting.reload
      expect {
        delete :destroy, params: { club_id: club.to_param, id: meeting.to_param }
      }.to change(Meeting, :count).by(-1)
    end

    it "redirects to the clubs list" do
      delete :destroy, params: { club_id: club.to_param, id: meeting.to_param }
      expect(response).to redirect_to(club_meetings_url(club))
    end
  end
end
