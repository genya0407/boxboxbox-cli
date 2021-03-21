class Config
  PROPS = [
    :access_token,
    :localizer_batch_size,
    :max_results,
    :min_percentage,
    :max_retry,
    :input_dir,
  ]
  IMAGE_EXTENSIONS = %w[png jpeg jpg]
  CONFIG_FILE='config.txt'
  
  PROPS.each do |prop|
    define_method prop do |*val|
      instance_variable_set("@#{prop}", val.first) unless val.empty?
      instance_variable_get("@#{prop}")
    end
  end

  def inspect
    "\#<#{self.class.name}#{PROPS.map { |prop| "#{prop} = #{instance_variable_get("@#{prop}").inspect}" }.join(' ')}>"
  end
end

def __main__(argv)
  script = File.read(Config::CONFIG_FILE)
  cfg = Config.new
  cfg.instance_eval(script)
  
  localizer = GoogleVisionApiOnline.new(
    access_token: cfg.access_token,
    max_results: cfg.max_results,
    min_percentage: cfg.min_percentage,
    max_retry: cfg.max_retry
  )
  
  input_files = Enumerator.new do |y|
    Dir.foreach(cfg.input_dir) do |fname|
      if IMAGE_EXTENSIONS.any? { |ext| fname.end_with?(ext) }
        content = File.read(File.join(cfg.input_dir, fname))
        y << BinaryImage.new(name: fname, binary: content)
      end
    end
  end

  boxes = Enumerator.new do |y|
    input_files.each_slice(cfg.localizer_batch_size) do |batch_images|
      localizer.localize(images: batch_images).each do |box|
        y << box
      end
    end
  end
  
  csv_string = CsvPresenter.new.present(boxes: boxes)
  output_fname = "#{Time.now.strftime('%Y%m%d%H%M%S')}.csv"
  File.open(output_fname, 'w').write(csv_string)
end

