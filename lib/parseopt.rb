class ParseOpt

  class Option
    attr_reader :short, :long

    def initialize(short, long, &block)
      @block = block
      @short = short
      @long = long
    end

    def call(v)
      @block.call(v)
    end
  end

  def initialize
    @list = {}
  end

  def on(short, long = nil, &block)
    opt = Option.new(short, long, &block)
    @list[short] = opt if short
    @list[long] = opt if long
  end

  def parse(args = ARGV)
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
      if opt
        opt.call(val)
        true
      end
    end
  end

end
