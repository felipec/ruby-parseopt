class ParseOpt

  def initialize
    @list = {}
  end

  def on(opt,  &block)
    @list[opt] = block
  end

  def parse(args = ARGV)
    args.delete_if do |cur|
      opt = val = nil
      next false if cur[0] != '-'
      case cur
      when /^-([^-])$/
        opt = @list[$1]
        val = true
      end
      opt&.call(val)
    end
  end

end
