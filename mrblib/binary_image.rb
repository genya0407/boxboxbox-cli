
class BinaryImage
  # @dynamic name, binary
  attr_reader :name, :binary

  def initialize(name:, binary:)
    @name = name
    @binary = binary
  end

  def inspect
    @name
  end
end
