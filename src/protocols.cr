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

macro defimpl(protocol, *, for klass, &block)
  {% if Reference.all_subclasses.includes?(klass.resolve) %}
    class {{klass}}
      include {{protocol}}
      module {{protocol}}Implementation
        {{block.body}}
      end
      include {{protocol}}Implementation
    end
  {% else %}
    struct {{klass}}
      include {{protocol}}
      module {{protocol}}Implementation
        {{block.body}}
      end
      include {{protocol}}Implementation
    end
  {% end %}
end

macro derive(protocol, *, from)
  include {{protocol}}Protocol
  include {{from}}::{{protocol}}Implementation
end

macro derive(protocol, *, for klass, from)
  {% if Reference.all_subclasses.includes?(klass.resolve) %}
    class {{klass}}
      include {{protocol}}
      include {{from}}::{{protocol}}Implementation
    end
  {% else %}
    struct {{klass}}
      include {{protocol}}
      include {{from}}::{{protocol}}Implementation
    end
  {% end %}
end
