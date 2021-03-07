# frozen_string_literal: true

class CsvPresenter
  def present(boxes:)
    csv = []
    csv << %w[name top_left_x top_left_y bottom_right_x bottom_right_y]
    boxes.each do |box|
      csv << [box.image_name, box.top_left.x, box.top_left.y, box.bottom_right.x, box.bottom_right.y]
    end
    csv.map do |line|
      line.map { |s| %Q{"#{s}"} }.join(',')
    end.join("\n")
  end
end
