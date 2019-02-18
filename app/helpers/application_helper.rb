module ApplicationHelper
  def club_nav?
    (controller_name == "clubs" && action_name != "index") ||
      controller_name == "meetings" ||
      controller_name == "meetings_attendances" ||
      controller_name == "members" ||
      controller_name == "members_attendances"
  end
end
