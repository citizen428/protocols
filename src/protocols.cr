require "./protocols/*"

macro defprotocol(name, &block)
  module {{name.id}}
    {{block.body}}
  end
end

macro defprotocol(name, *methods)
  module {{name.id}}
    {% for method in methods %}
      abstract def {{method.id}}
    {% end %}
  end
end

macro defimpl(protocol, &block)
  include {{protocol}}
  module {{protocol}}Implementation
    {{block.body}}
  end
  include {{protocol}}Implementation
end

macro derive(protocol, *, from)
  include {{protocol}}Protocol
  include {{from}}::{{protocol}}Implementation
end
