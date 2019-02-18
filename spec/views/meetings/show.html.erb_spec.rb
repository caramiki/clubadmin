require "rails_helper"

RSpec.describe "meetings/show", type: :view do
  let(:club) { create(:club) }
  let(:meeting) { create(:meeting) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the meeting view" do
    render template: "meetings/show.html.erb", locals: { club: club, meeting: meeting }
  end
end
