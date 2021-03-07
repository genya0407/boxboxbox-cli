# frozen_string_literal: true

class GoogleVisionApiOnline
  URL = 'https://vision.googleapis.com/v1/images:annotate'
  PERSON_LABEL = 'Person'

  def initialize(access_token:, max_results:, min_percentage:, max_retry:, logger: Logger.new(STDERR))
    @access_token = access_token
    @max_results = max_results
    @min_percentage = min_percentage
    @max_retry = max_retry
    @logger = logger
  end

  def localize(images:)
    boxes = Array.new
    remaining_retry_count = @max_retry

    # 失敗したらmax_retry回リトライする。
    # リトライの間隔は指数的に伸ばす
    loop do
      result = exec_request(images: images)
      boxes.concat(result[:success_boxes])

      break if result[:failed_images].empty?
      break if remaining_retry_count.zero?

      sleep(2**(@max_retry - remaining_retry_count))
      remaining_retry_count -= 1
      images = result[:failed_images]
    end

    boxes
  end

  private

  def exec_request(images:)
    success_boxes = []
    failed_images = []
    
    images.each do |image|
      http = SimpleHttp.new('https', 'vision.googleapis.com')
      body = JSON.generate(
        {
          "requests": [
            {
              "image": {
                "content": Base64.encode(image.binary)
              },
              "features": [
                {
                  "maxResults": @max_results,
                  "type": 'OBJECT_LOCALIZATION'
                }
              ]
            }
          ]
        }
      )
      header = { 'Content-Type' => 'application/json; charset=utf-8' }
      req = header.merge('Body' => body)
      response = http.post(sprintf("/v1/images:annotate?key=%s", @access_token), req)
      person_vertices = response2person_vertices(response_body: response.body)
      person_vertices.each do |vertices|
        success_boxes << vertices2box(image_name: image.name, vertices: vertices)
      end
    end

    { success_boxes: success_boxes.to_a, failed_images: failed_images.to_a }
  end

  def vertices2box(image_name:, vertices:)
    xs = vertices.map { |vertice| vertice[:x]&.to_f || 0.0 }
    ys = vertices.map { |vertice| vertice[:y]&.to_f || 0.0 }
    Box.new(
      image_name: image_name,
      top_left: Point.new(x: xs.min || 0.0, y: ys.min || 0.0),
      bottom_right: Point.new(x: xs.max || 0.0, y: ys.max || 0.0)
    )
  end

  def response2person_vertices(response_body:)
    localized_object_annotations = JSON.parse(response_body).dig('responses', 0, 'localizedObjectAnnotations') || []
    localized_object_annotations.select { |annot| annot['name'] == PERSON_LABEL }
                                .select { |annot| annot['score'] >= @min_percentage }
                                .map { |annot| annot.dig('boundingPoly', 'normalizedVertices') }
  end
end
