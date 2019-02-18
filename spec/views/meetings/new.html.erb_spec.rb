require "rails_helper"

RSpec.describe "meetings/new", type: :view do
  let(:club) { create(:club) }
  let(:meeting) { build(:meeting, club: club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders new meeting form" do
    render template: "meetings/new.html.erb", locals: { club: club, meeting: meeting }

    assert_select "form[action=?][method=?]", club_meetings_path(club), "post" do
    end
  end
end
