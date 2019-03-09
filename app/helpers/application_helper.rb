module ApplicationHelper
  def club_nav?
    (controller_name == "clubs" && ["show", "edit", "update"].include?(action_name)) ||
      controller_name == "meetings" ||
      controller_name == "meeting_attendances" ||
      controller_name == "members" ||
      controller_name == "member_attendances"
  end
end
