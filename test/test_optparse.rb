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

  def test_unknown
    run_opts('b', %w[-x], %w[-x])
  end

  def test_other
    run_opts('b', %w[foo], %w[foo])
  end

  def test_other_then_bool
    bool = false
    run_opts('b', %w[foo -b], %w[foo]) { |v| bool = v }
    assert(bool)
  end

  def test_double_dash
    run_opts('b', %w[-- -b], %w[-b])
  end

  private

  def run_opts(opt, args, result = [])
    opts = ParseOpt.new
    opts.on(opt) { |v| yield v }
    assert_equal(result, opts.parse(args))
  end

end
