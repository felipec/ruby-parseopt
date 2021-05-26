require 'test/unit'
require 'parseopt'
require 'stringio'

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

  def test_value
    str = 'default'
    run_opts('s', %w[-sfoo]) { |v| str = v }
    assert_equal('foo', str)
  end

  def test_long
    bool = false
    run_opts(['b', 'bool'], %w[--bool]) { |v| bool = v }
    assert(bool)
  end

  def test_long_value
    str = 'default'
    run_opts(['s', 'string'], %w[--string=foo]) { |v| str = v }
    assert_equal('foo', str)
  end

  def test_no_long
    bool = true
    run_opts(['b', 'bool'], %w[--no-bool]) { |v| bool = v }
    assert(!bool)
  end

  def test_init
    bool = false
    ParseOpt.new('test script') do |opts|
      opts.on('b', 'bool') { |v| bool = v }
    end.parse(%w[-b])
    assert(bool)
  end

  def test_usage
    expected = <<~EOF
    usage: 
        -b, --bool
    EOF
    run_usage(['b', 'bool'], expected) { |opts| opts.usage }
  end

  def test_help
    expected = <<~EOF
    usage: 
        -b, --bool
    EOF
    run_usage(['b', 'bool'], expected) do |opts|
      begin
        opts.parse(%w[-h])
      rescue SystemExit
      end
    end
  end

  def test_custom_usage
    expected = <<~EOF
    usage: test script
        -b, --bool
    EOF
    run_usage(['b', 'bool'], expected) do |opts|
      opts.usage = 'test script'
      opts.usage
    end
  end

  def test_option_help
    expected = <<~EOF
    usage: 
        -b, --bool            Boolean
    EOF
    run_usage(['b', 'bool', 'Boolean'], expected) { |opts| opts.usage }
  end

  private

  def run_opts(opt, args, result = [])
    opts = ParseOpt.new
    opts.on(*opt) { |v| yield v }
    assert_equal(result, opts.parse(args))
  end

  def run_usage(opt, expected)
    opts = ParseOpt.new
    opts.on(*opt)
    assert_equal(expected, capture { yield opts })
  end

  def capture
    stdout_save = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = stdout_save
  end

end
