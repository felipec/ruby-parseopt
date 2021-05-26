require 'test/unit'
require 'parseopt'

class ParseOptTest < Test::Unit::TestCase

  def test_bool
    bool = false
    run_opts('b', %w[-b]) { |v| bool = v }
    assert(bool)
  end

  def test_empty_bool
    bool = false
    run_opts('b', []) { |v| bool = v }
    assert(!bool)
  end

  private

  def run_opts(opt, args, result = [])
    opts = ParseOpt.new
    opts.on(opt) { |v| yield v }
    assert_equal(result, opts.parse(args))
  end

end
