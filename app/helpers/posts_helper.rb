module PostsHelper
  def display_image(image, size = 400)
    image.variant(resize_to_limit: [size, size])
  end

end
