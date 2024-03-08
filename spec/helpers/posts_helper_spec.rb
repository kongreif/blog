# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsHelper do
  describe '#rouge_syntax_highlighting_css' do
    it 'generates CSS for syntax highlighting' do
      css = helper.rouge_syntax_highlighting_css
      expect(css).to include('.highlight')
    end
  end

  describe '#markdown' do
    let(:markdown_text) { "## Heading\n\nSome **bold** text" }
    let(:html_output) { helper.markdown(markdown_text) }

    it 'converts markdown to HTML' do
      expect(html_output).to include('<h2>Heading</h2>')
      expect(html_output).to include('<strong>bold</strong>')
    end

    it 'sanitizes the HTML output' do
      sanitized_markdown = "<script>alert('XSS');</script>"
      sanitized_output = helper.markdown(sanitized_markdown)
      expect(sanitized_output).not_to include('<script>')
    end

    it 'applies Rouge syntax highlighting for code blocks' do
      code_markdown = "```ruby\ndef hello\n  puts 'world'\nend\n```"
      code_output = helper.markdown(code_markdown)
      expect(code_output).to include('<pre')
      expect(code_output).to include('<code')
    end
  end
end
