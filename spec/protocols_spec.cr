require "./spec_helper"

defprotocol Test, :protocol_working?

class Array
  defimpl Test do
    def protocol_working?
      true
    end
  end
end

class String
  defimpl Test do
    def protocol_working?
      true
    end
  end
end

class Hash
  derive Test, from: Array
end

describe Protocols do
  describe "defprotocol" do

  end

  describe "defimpl" do
    it "adds an implementation of the method" do
      Array(Int32).new.protocol_working?.should eq true
    end

    it "allows multiple classes to implement the same protocol" do
      "".protocol_working?.should eq true
    end
  end

  describe "derive" do
    it "derives the protocol implementation from another class" do
      Hash(Symbol, String).new.protocol_working?.should eq true
    end
  end
end
