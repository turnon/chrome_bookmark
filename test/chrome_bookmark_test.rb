require 'test_helper'

class ChromeBookmarkTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ChromeBookmark::VERSION
  end

end
