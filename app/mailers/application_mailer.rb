# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@em5332.kongreif.com'
  layout 'mailer'
end
