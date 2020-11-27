module UsersHelper

  def profile_image(image)
    image.variant(resize_to_fit: [180, 180])
  end

  def user_icon(image)
    image.variant(resize_to_fit: [40, 40])
  end

  def nav_user_icon(image)
    image.variant(resize_to_fit: [20, 20])
  end
end