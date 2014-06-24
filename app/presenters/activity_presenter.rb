class ActivityPresenter < SimpleDelegator
  attr_reader :activity

  def initialize(activity, view)
    super(view)
    @activity = activity
  end

  def render_activity
    if activity.user == current_user
      name = I18n.t("activity.you")
    else
      name = activity.user.name
    end

    div_for activity do
      link_to(name, activity.user) +
              " " +
              render_partial
    end
  end

  def render_partial
    locals = { activity: activity,
               presenter: self,
               trackable: activity.trackable }
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "activities/#{activity.trackable_type.underscore}/#{activity.action}",
      "activities/#{activity.trackable_type.underscore}",
      "activities/activity"
    ]
  end
end
