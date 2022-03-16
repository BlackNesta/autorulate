module PostsHelper
  def display_image(image)
    image.variant(resize_to_limit: [500, 500])
  end
end
