A very simple option parser.

It uses as inspiration Git's internal option parser code, and Ruby's
OptionParser.

```ruby
require 'parseopt'

opts = ParseOpt.new('my command')

# only short
opts.on('b') do |v|
 $bool = v
end

# short and long
opts.on('s', 'string') do |v|
 $string = v
end

# short, long, and help
opts.on('n', 'number', 'Number') do |v|
 $number = v.to_i
end

opts.parse
```

Running with `--help` gives:

```
usage: my command
    -b
    -s, --string
    -n, --number          Number
```

## Installation

Simply install the gem:

    gem install parseopt
