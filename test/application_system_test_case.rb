require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::RecordIdentifier

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers
    end.new
  end

  if ENV['SELENIUM_REMOTE_URL'].present?
    driven_by :selenium,
      using: :headless_chrome,
      screen_size: [1400, 1400],
      options: {
        url: ENV['SELENIUM_REMOTE_URL']
      }

    def setup
      Capybara.server_host = '0.0.0.0'
      Capybara.default_max_wait_time = 10
      super
    end
  else
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end
end
