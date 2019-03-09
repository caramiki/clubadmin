class ClubsController < ApplicationController
  def index
    authorize clubs

    render :index, locals: { clubs: clubs }
  end

  def show
    authorize club

    render :show, locals: { club: club }
  end

  def new
    authorize club

    render :new, locals: { club: club }
  end

  def edit
    authorize club

    render :edit, locals: { club: club }
  end

  def create
    club.assign_attributes club_params

    authorize club

    if club.save
      redirect_to club, notice: t(:created, scope: [:globals], item: Club.name)
    else
      render :new, locals: { club: club }
    end
  end

  def update
    club.assign_attributes club_params

    authorize club

    if club.save
      redirect_to club, notice: t(:updated, scope: [:globals], item: Club.name)
    else
      render :edit, locals: { club: club }
    end
  end

  def destroy
    authorize club

    club.destroy

    redirect_to clubs_url, notice: t(:destroyed, scope: [:globals], item: Club.name)
  end

  private

  def club
    @club ||=
      if params[:id].present?
        Club.find_by!(id: params[:id])
      else
        Club.new
      end
  end

  def clubs
    @clubs ||= policy_scope(Club)
  end

  def club_params
    permitted_attributes(club)
  end
end
