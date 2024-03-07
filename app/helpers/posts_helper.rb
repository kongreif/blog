# frozen_string_literal: true

module PostsHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    renderer = HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
    }
    # rubocop:disable Rails/OutputSafety
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
