class NotificationPresenter < SimpleDelegator
  attr_reader :notification

  def initialize(notification, view)
    super(view)
    @notification = notification
  end

  def render_notification
    div_for notification do
      render_partial
    end
  end

  def render_partial
    locals = { notification: notification,
               presenter: self,
               type: notification.trackable_type }
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "notifications/#{notification.trackable_type.underscore}"
    ]
  end
end
