# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@kongreif.com'
  layout 'mailer'
end
