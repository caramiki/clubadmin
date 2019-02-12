class MembersController < ApplicationController
  def index
    authorize members

    render :index, locals: { club: club, members: members }
  end

  def show
    authorize member

    render :show, locals: { club: club, member: member }
  end

  def new
    authorize member

    render :new, locals: { club: club, member: member }
  end

  def edit
    authorize member

    render :edit, locals: { club: club, member: member }
  end

  def create
    member.assign_attributes member_params

    authorize member

    if member.save
      redirect_to club_member_url(club, member), notice: t(:created, scope: [:globals], item: Member.name)
    else
      render :new, locals: { club: club, member: member }
    end
  end

  def update
    member.assign_attributes member_params

    authorize member

    if member.save
      redirect_to club_member_url(club, member), notice: t(:updated, scope: [:globals], item: Member.name)
    else
      render :edit, locals: { club: club, member: member }
    end
  end

  def destroy
    authorize member

    member.destroy

    redirect_to club_members_url(club), notice: t(:destroyed, scope: [:globals], item: Member.name)
  end

  private

  def club
    @club ||= Club.find_by!(id: params[:club_id])
  end

  def member
    @member ||=
      if params[:id].present?
        Member.find_by!(id: params[:id])
      else
        club.members.build
      end
  end

  def members
    @members ||= policy_scope(club.members)
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :notes)
  end
end
