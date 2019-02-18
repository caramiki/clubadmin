class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    current_user || User.new
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    model_name = exception.policy.class.record_class.model_name

    flash[:alert] = t(
      "#{policy_name}.#{exception.query}",
      item: model_name.singular,
      items: model_name.plural,
      scope: "pundit",
      default: :"default.#{exception.query}"
    )

    redirect_to root_path
  end
end
