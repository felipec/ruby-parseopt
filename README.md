A ver simple option parser.

```ruby
opts = ParseOpt.new
opts.usage = 'my command'

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
