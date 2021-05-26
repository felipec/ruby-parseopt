class ParseOpt

  def initialize
    @list = {}
  end

  def on(short, long = nil, &block)
    @list[short] = block if short
    @list[long] = block if long
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
      when /^-([^-])(.+)?$/, /^--(.+?)(?:=(.+))?$/
        opt = @list[$1]
        val = $2 || true
      end
      opt&.call(val)
    end
  end

end
