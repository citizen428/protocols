require "./protocols/*"

macro defprotocol(name, &block)
  module {{name.id}}Protocol
    {{block.body}}
  end
end

macro defprotocol(name, *methods)
  module {{name.id}}Protocol
    {% for method in methods %}
      abstract def {{method.id}}
    {% end %}
  end
end

macro defimpl(protocol, &block)
  include {{protocol.id}}Protocol
  module {{protocol.id}}Implementation
    {{block.body}}
  end
  include {{protocol.id}}Implementation
end

macro derive(protocol, *, from)
  include {{protocol.id}}Protocol
  include {{from.id}}::{{protocol.id}}Implementation
end
