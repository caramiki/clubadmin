require "rails_helper"

RSpec.describe "meetings/index", type: :view do
  let(:club) { create(:club) }
  let(:meetings) { create_list(:meeting, 3, club: club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders a list of meetings" do
    render template: "meetings/index.html.erb", locals: { club: club, meetings: meetings }
  end
end
