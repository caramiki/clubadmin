require "rails_helper"

RSpec.describe "meetings/edit", type: :view do
  let(:club) { create(:club) }
  let(:meeting) { create(:meeting) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the edit meeting form" do
    render template: "meetings/edit.html.erb", locals: { club: club, meeting: meeting }

    assert_select "form[action=?][method=?]", club_meeting_path(club, meeting), "post" do
    end
  end
end
