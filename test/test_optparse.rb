require 'test/unit'
require 'parseopt'

class ParseOptTest < Test::Unit::TestCase

  def test_bool
    bool = false
    opts = ParseOpt.new
    opts.on('b') { |v| bool = v }
    assert_equal(opts.parse(%w[-b]), [])
    assert(bool)
  end

end
