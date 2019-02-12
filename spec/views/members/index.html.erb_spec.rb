require "rails_helper"

RSpec.describe "members/index", type: :view do
  let(:club) { create(:club) }
  let(:members) { create_list(:member, 3, club: club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders a list of members" do
    render template: "members/index.html.erb", locals: { club: club, members: members }
  end
end
