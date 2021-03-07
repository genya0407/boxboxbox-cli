
class Box
  # @dynamic image_name, top_left, bottom_right
  attr_reader :image_name, :top_left, :bottom_right

  def initialize(image_name:, top_left:, bottom_right:)
    @image_name = image_name
    @top_left = top_left
    @bottom_right = bottom_right
  end
end
