module Markdown
  def self.get
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,
                            autolink: true,
                            space_after_headers: true)
  end
end
