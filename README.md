# protocols

`defprotocol` and `defimpl` macros inspired by [Elixir](http://elixir-lang.org/getting-started/protocols.html).

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  protocols:
    github: citizen428/protocols
```


## Usage


```crystal
require "protocols"
```

### Definining protocols

`defprotocol` is used for defining new protocols (which will be created as toplevel modules).

```crystal
defprotocol Greetable do
  def greet
    "Hello from #{name}"
  end
  
  abstract def name
end
```

The above form allows us to specify both concrete and abstract methods for the protocol. There is also a shortcut for protocols which only contain abstract methods:

```crystal
defprotocol AbstractGreetable, :greet, :name
```

### Implementing protocols

Given the below `Blank` protocol, we have several ways of implementing it.

```crystal
# Returns true if if data is considered blank/empty    
defprotocol Blank, :blank?
```

One way is to use `defimpl` with the `for:` argument, which can be used on the toplevel and is handy if you want to keep all your implementations close to each other.

```crystal
defimpl Blank, for: Array do
  def blank
    empty?
  end
end

Array(String).new.blank? #=> true
```

Alternatively you can define an implementation inside a class or struct body:

```crystal
struct Nil
  defimpl Blank do
    def blank?
      true
    end
  end
end

nil.blank? #=> true
```

In both cases `defimpl` will `include` the protocol module, define a nested module called `"#{protocol_name}Implementation"` and include this module too. While this may seem complicated, it makes it possible to `derive` implementations from other classes.

### Deriving protocols

To avoid code duplication, it's possible to `derive` protocol implementations from other classes/structs:

```crystal
struct Tuple
  derive Blank, from: Array        
end
        
Tuple.new.blank? #=> true  
```

Alternatively you can also use the `for:` argument.

```crystal
class Foo
  def empty?
    false
  end
end

derive Blank, for: Foo, from: Array 
Foo.new.blank? #=> false
```

## Todo

* [ ] Write specs
* [ ] Try to reduce code duplication

## Contributing

1. Fork it ( https://github.com/citizen428/protocols/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [citizen428](https://github.com/citizen428) Michael Kohl - creator, maintainer
