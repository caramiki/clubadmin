require "rails_helper"

RSpec.describe "members/new", type: :view do
  let(:club) { create(:club) }
  let(:member) { build(:member, club: club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders new member form" do
    render template: "members/new.html.erb", locals: { club: club, member: member }

    assert_select "form[action=?][method=?]", club_members_path(club), "post" do
    end
  end
end
