require "rails_helper"

RSpec.describe "members/edit", type: :view do
  let(:club) { create(:club) }
  let(:member) { create(:member) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the edit member form" do
    render template: "members/edit.html.erb", locals: { club: club, member: member }

    assert_select "form[action=?][method=?]", club_member_path(club, member), "post" do
    end
  end
end
