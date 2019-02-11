require "rails_helper"

RSpec.describe "clubs/show", type: :view do
  let(:club) { create(:club) }
  let(:user) { create(:user, :super_admin) }
  before(:each) { sign_in user }

  it "renders the club view" do
    render template: "clubs/show.html.erb", locals: { club: club }
  end
end
