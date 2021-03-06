module ApplicationHelper
  def admin?
    redirect_to root_url unless current_user.admin?
  end

  def resize20(image)
    image.variant(resize_to_fit: [20, 20])
  end

  def resize40(image)
    image.variant(resize_to_fit: [40, 40])
  end

  def resize180(image)
    image.variant(resize_to_fit: [180, nil])
  end

  def resize300(image)
    image.variant(resize_to_fill: [300, 300])
  end
end
