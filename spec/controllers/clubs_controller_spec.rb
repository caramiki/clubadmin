require "rails_helper"

RSpec.describe ClubsController, type: :controller do
  let(:valid_attributes) { attributes_for(:club) }
  let(:invalid_attributes) { attributes_for(:club, :invalid) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  describe "GET #index" do
    it "returns a success response" do
      create(:club)
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      club = create(:club)
      get :show, params: { id: club.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      club = create(:club)
      get :edit, params: { id: club.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Club" do
        expect {
          post :create, params: { club: valid_attributes }
        }.to change(Club, :count).by(1)
      end

      it "redirects to the created club" do
        post :create, params: { club: valid_attributes }
        expect(response).to redirect_to(Club.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { club: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    let(:club) { create(:club) }

    context "with valid params" do
      let(:new_name) { club.name.next } # e.g. "Lorem" becomes "Loren"
      
      it "updates the requested club" do
        put :update, params: { id: club.to_param, club: { name: new_name } }
        club.reload
        expect(club.name).to eq(new_name)
      end

      it "redirects to the club" do
        put :update, params: { id: club.to_param, club: { name: new_name } }
        expect(response).to redirect_to(club)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: club.to_param, club: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    let(:club) { create(:club) }

    it "destroys the requested club" do
      club.reload
      expect {
        delete :destroy, params: { id: club.to_param }
      }.to change(Club, :count).by(-1)
    end

    it "redirects to the clubs list" do
      delete :destroy, params: { id: club.to_param }
      expect(response).to redirect_to(clubs_url)
    end
  end
end
