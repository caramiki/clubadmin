require "rails_helper"

describe ClubPolicy do
  let(:club) { create(:club) }
  let(:visitor) { User.new }
  let(:user) { create(:user) }
  let(:super_admin) { create(:user, :super_admin) }

  context "for visitor" do
    let(:policy) { ClubPolicy.new(visitor, club) }

    it "returns false for #index?" do
      expect(policy.index?).to be_falsey
    end

    it "returns false for #show?" do
      expect(policy.show?).to be_falsey
    end

    it "returns false for #create?" do
      expect(policy.create?).to be_falsey
    end

    it "returns false for #new?" do
      expect(policy.new?).to be_falsey
    end

    it "returns false for #update?" do
      expect(policy.update?).to be_falsey
    end

    it "returns false for #edit?" do
      expect(policy.edit?).to be_falsey
    end

    it "returns false for #destroy?" do
      expect(policy.destroy?).to be_falsey
    end
  end

  context "for regular user" do
    let(:policy) { ClubPolicy.new(user, club) }

    it "returns true for #index?" do
      expect(policy.index?).to be_truthy
    end

    it "returns true for #create?" do
      expect(policy.create?).to be_truthy
    end

    it "returns true for #new?" do
      expect(policy.create?).to be_truthy
    end

    context "for an organizer of the club" do
      let(:role) { create(:role, user: user, club: club, level: :organizer) }
      let(:policy) { ClubPolicy.new(user, club) }
      before(:each) { role.reload }

      it "returns true for #show?" do
        expect(policy.show?).to be_truthy
      end

      it "returns false for #update?" do
        expect(policy.update?).to be_falsey
      end

      it "returns false for #edit?" do
        expect(policy.edit?).to be_falsey
      end

      it "returns false for #destroy?" do
        expect(policy.destroy?).to be_falsey
      end
    end

    context "for an admin of the club" do
      let(:role) { create(:role, user: user, club: club, level: :admin) }
      let(:policy) { ClubPolicy.new(user, club) }
      before(:each) { role.reload }

      it "returns true for #show?" do
        expect(policy.show?).to be_truthy
      end

      it "returns true for #update?" do
        expect(policy.update?).to be_truthy
      end

      it "returns true for #edit?" do
        expect(policy.edit?).to be_truthy
      end

      it "returns true for #destroy?" do
        expect(policy.destroy?).to be_truthy
      end
    end

    context "for an unrelated user" do
      it "returns false for #show?" do
        expect(policy.show?).to be_falsey
      end

      it "returns false for #update?" do
        expect(policy.update?).to be_falsey
      end

      it "returns false for #edit?" do
        expect(policy.edit?).to be_falsey
      end

      it "returns false for #destroy?" do
        expect(policy.destroy?).to be_falsey
      end
    end
  end

  context "for super admin" do
    let(:policy) { ClubPolicy.new(super_admin, club) }

    it "returns true for #index?" do
      expect(policy.index?).to be_truthy
    end

    it "returns true for #show?" do
      expect(policy.show?).to be_truthy
    end

    it "returns true for #create?" do
      expect(policy.create?).to be_truthy
    end

    it "returns true for #new?" do
      expect(policy.new?).to be_truthy
    end

    it "returns true for #update?" do
      expect(policy.update?).to be_truthy
    end

    it "returns true for #edit?" do
      expect(policy.edit?).to be_truthy
    end

    it "returns true for #destroy?" do
      expect(policy.destroy?).to be_truthy
    end
  end
end
