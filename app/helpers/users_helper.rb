module UsersHelper
  def gravatar_for(user)
    gravatar_url = Gravatar.new(@user.email.downcase).image_url
    image_tag("https://images.unsplash.com/photo-1563826773-1e2b4b2cde42", alt: user.name, style: "width: 100px; height: 100px;")
  end
end
