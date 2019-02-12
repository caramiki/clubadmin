require "rails_helper"

RSpec.describe MembersController, type: :controller do
  let(:valid_attributes) { attributes_for(:member) }
  let(:invalid_attributes) { attributes_for(:member, :invalid) }
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
      member = create(:member, club: club)
      get :show, params: { club_id: club.to_param, id: member.to_param }
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
      member = create(:member, club: club)
      get :edit, params: { club_id: club.to_param, id: member.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Member" do
        club.members.reload
        expect {
          post :create, params: { club_id: club.to_param, member: valid_attributes }
        }.to change(club.members, :count).by(1)
      end

      it "redirects to the created club" do
        post :create, params: { club_id: club.to_param, member: valid_attributes }
        expect(response).to redirect_to(club_member_url(club, Member.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { club_id: club.to_param, member: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    let(:member) { create(:member, club: club) }

    context "with valid params" do
      let(:new_first_name) { member.first_name.next } # e.g. "Lorem" becomes "Loren"
      
      it "updates the requested member" do
        put :update, params: {
          club_id: club.to_param, id: member.to_param, member: { first_name: new_first_name }
        }
        member.reload
        expect(member.first_name).to eq(new_first_name)
      end

      it "redirects to the member" do
        put :update, params: {
          club_id: club.to_param, id: member.to_param, member: { first_name: new_first_name }
        }
        expect(response).to redirect_to(club_member_url(club, member))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {
          club_id: club.to_param, id: member.to_param, member: invalid_attributes
        }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    let(:member) { create(:member, club: club) }

    it "destroys the requested member" do
      member.reload
      expect {
        delete :destroy, params: { club_id: club.to_param, id: member.to_param }
      }.to change(Member, :count).by(-1)
    end

    it "redirects to the clubs list" do
      delete :destroy, params: { club_id: club.to_param, id: member.to_param }
      expect(response).to redirect_to(club_members_url(club))
    end
  end
end
