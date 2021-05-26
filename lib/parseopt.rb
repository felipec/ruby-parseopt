class ParseOpt
  attr_writer :usage

  class Option
    attr_reader :short, :long, :help

    def initialize(short, long, help, &block)
      @block = block
      @short = short
      @long = long
      @help = help
    end

    def call(v)
      @block.call(v) || true
    end
  end
  private_constant :Option

  def initialize(usage = nil)
    @list = {}
    @usage = usage
    yield self if block_given?
  end

  def on(short, long = nil, help = nil, &block)
    opt = Option.new(short, long, help, &block)
    @list[short] = opt if short
    @list[long] = opt if long
  end

  def parse(args = ARGV)
    if args.member?('-h') or args.member?('--help')
      usage
      exit 0
    end
    seen_dash = false
    args.delete_if do |cur|
      opt = val = nil
      next false if cur[0] != '-' or seen_dash
      case cur
      when '--'
        seen_dash = true
        next true
      when /^--no-(.+)$/
        opt = @list[$1]
        val = false
      when /^-([^-])(.+)?$/, /^--(.+?)(?:=(.+))?$/
        opt = @list[$1]
        val = $2 || true
      end
      opt&.call(val)
    end
  end

  def usage
    puts 'usage: %s' % @usage
    @list.values.uniq.each do |opt|
      s = '    '
      s << ''
      s << [opt.short&.prepend('-'), opt.long&.prepend('--')].compact.join(', ')
      s << ''
      s << '%*s%s' % [26 - s.size, '', opt.help] if opt.help
      puts s
    end
  end

end
