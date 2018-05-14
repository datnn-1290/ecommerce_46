class CategoriesController < AppllicationController
  before_action :load_products, only: %i(show)


  private

    def load_products
      @products = Product.search_by_category params[:id]
    end
end
