module ProductsHelper
  def show_image product
    if product.image.present?
      image_tag("/img/default.jpg", class: "img-responsive")
    end
  end
end
