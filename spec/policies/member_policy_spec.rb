require "rails_helper"

describe MemberPolicy do
  let(:member) { create(:member) }

  context "for visitor" do
    let(:visitor) { User.new }
    let(:policy) { MemberPolicy.new(visitor, member) }

    it "returns false for #index?" do
      policy = MemberPolicy.new(visitor, member.club.members)

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
    let(:user) { create(:user) }
    let(:policy) { MemberPolicy.new(user, member) }

    context "for an organizer of the member's club" do
      let(:role) { create(:role, user: user, club: member.club, level: :organizer) }
      let(:policy) { MemberPolicy.new(user, member) }
      before(:each) { role.reload }

      it "returns true for #index?" do
        policy = MemberPolicy.new(user, member.club.members)

        expect(policy.index?).to be_truthy
      end

      it "returns true for #create?" do
        expect(policy.create?).to be_truthy
      end

      it "returns true for #new?" do
        expect(policy.create?).to be_truthy
      end

      it "returns true for #show?" do
        expect(policy.show?).to be_truthy
      end

      it "returns true for #update?" do
        expect(policy.update?).to be_truthy
      end

      it "returns true for #edit?" do
        expect(policy.edit?).to be_truthy
      end

      it "returns false for #destroy?" do
        expect(policy.destroy?).to be_falsey
      end
    end

    context "for an admin of the club" do
      let(:role) { create(:role, user: user, club: member.club, level: :admin) }
      let(:policy) { MemberPolicy.new(user, member) }
      before(:each) { role.reload }

      it "returns true for #index?" do
        policy = MemberPolicy.new(user, member.club.members)

        expect(policy.index?).to be_truthy
      end

      it "returns true for #create?" do
        expect(policy.create?).to be_truthy
      end

      it "returns true for #new?" do
        expect(policy.create?).to be_truthy
      end

      it "returns true for #show?" do
        expect(policy.show?).to be_truthy
      end

      it "returns true for #update?" do
        expect(policy.update?).to be_truthy
      end

      it "returns true for #edit?" do
        expect(policy.edit?).to be_truthy
      end

      describe "#destroy?" do
        it "returns true" do
          expect(policy.destroy?).to be_truthy
        end
        
        it "returns false if the member is associated with a user" do
          creator_membership = member.club.creator.membership(member.club)
          policy = MemberPolicy.new(user, creator_membership)

          expect(policy.destroy?).to be_falsey
        end
      end
    end

    context "for an unrelated user" do
      it "returns false for #index?" do
        policy = MemberPolicy.new(user, member.club.members)

        expect(policy.index?).to be_falsey
      end

      it "returns false for #create?" do
        expect(policy.create?).to be_falsey
      end

      it "returns false for #new?" do
        expect(policy.create?).to be_falsey
      end

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
    let(:super_admin) { create(:user, :super_admin) }
    let(:policy) { MemberPolicy.new(super_admin, member) }

    it "returns true for #index?" do
      policy = MemberPolicy.new(super_admin, member.club.members)

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

    describe "#destroy?" do
      it "returns true" do
        expect(policy.destroy?).to be_truthy
      end
      
      it "returns false if the member is associated with a user" do
        creator_membership = member.club.creator.membership(member.club)
        policy = MemberPolicy.new(super_admin, creator_membership)

        expect(policy.destroy?).to be_falsey
      end
    end
  end
end
