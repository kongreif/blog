# frozen_string_literal: true

class ConfirmExistingUsers < ActiveRecord::Migration[6.1]
  def up
    # rubocop:disable Rails/SkipsModelValidations
    User.update_all(confirmed_at: Time.current)
  end

  def down
    User.update_all(confirmed_at: nil)
    # rubocop:enable Rails/SkipsModelValidations
  end
end
