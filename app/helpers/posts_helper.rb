module PostsHelper
  def display_image(image, size = 400)
    image.variant(resize_to_limit: [size, size])
  end

  def resize_to_fill(image, w = 425, h = 250)
    image.variant(resize_to_fill: [w, h])
  end

end
