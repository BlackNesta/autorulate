module PostsHelper
  def display_image(image)
    image.variant(resize_to_limit: [400, 400])
  end
end
