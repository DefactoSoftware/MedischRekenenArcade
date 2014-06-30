class MessagePresenter < SimpleDelegator
  attr_reader :message

  def initialize(message, view)
    super(view)
    @message = message
  end

  def render_message
    div_for message do
      render_partial
    end
  end

  def render_partial
    locals = { message: message, presenter: self, type: message.trackable_type }
    render partial_path, locals
  end

  def partial_path
    partial_paths.detect do |path|
      lookup_context.template_exists? path, nil, true
    end || raise("No partial found for activity in #{partial_paths}")
  end

  def partial_paths
    [
      "messages/#{message.trackable_type.underscore}"
    ]
  end
end
