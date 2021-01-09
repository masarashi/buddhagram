module StatuesHelper
  
  def resize120(image)
    image.variant(resize_to_fill: [180, nil])
  end
end
