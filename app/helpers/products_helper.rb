module ProductsHelper
  def show_image_product product
    image_tag product.image.url, class: "img-responsive"
  end
end
