require "rails_helper"

describe AttendancePolicy do
  let(:attendance) { create(:attendance)}
  let(:attendances) { attendance.meeting.attendances }

  context "for visitor" do
    let(:visitor) { User.new }
    let(:policy) { AttendancePolicy.new(visitor, attendances) }

    it "returns false for #index?" do
      expect(policy.index?).to be_falsey
    end

    it "returns false for #update?" do
      expect(policy.update?).to be_falsey
    end
  end

  context "for regular user" do
    let(:user) { create(:user) }

    context "for an organizer of the meeting's club" do
      let(:role) { create(:role, user: user, club: attendance.club, level: :organizer) }
      let(:policy) { AttendancePolicy.new(user, attendances) }
      before(:each) { role.reload }

      it "returns true for #index?" do
        expect(policy.index?).to be_truthy
      end

      it "returns true for #update?" do
        expect(policy.update?).to be_truthy
      end
    end

    context "for an admin of the club" do
      let(:role) { create(:role, user: user, club: attendance.club, level: :admin) }
      let(:policy) { AttendancePolicy.new(user, attendances) }
      before(:each) { role.reload }

      it "returns true for #index?" do
        expect(policy.index?).to be_truthy
      end

      it "returns true for #update?" do
        expect(policy.update?).to be_truthy
      end
    end

    context "for an unrelated user" do
      let(:policy) { AttendancePolicy.new(user, attendances) }

      it "returns false for #index?" do
        expect(policy.index?).to be_falsey
      end

      it "returns false for #update?" do
        expect(policy.update?).to be_falsey
      end
    end
  end

  context "for super admin" do
    let(:super_admin) { create(:user, :super_admin) }
    let(:policy) { AttendancePolicy.new(super_admin, attendances) }

    it "returns true for #index?" do
      expect(policy.index?).to be_truthy
    end

    it "returns true for #update?" do
      expect(policy.update?).to be_truthy
    end
  end
end
