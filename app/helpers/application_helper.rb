module ApplicationHelper
  def club_nav?
    (controller_name == "clubs" && action_name != "index") ||
      controller_name == "meetings" ||
      controller_name == "members"
  end
end
