class CommentsController < ApplicationController
  before_action :load_product
  before_action :load_comment, only: %i(edit update destroy)

  def create
    @comment = current_user.comments.build comment_params
    respond_to do |format|
      if @comment.save
        format.html {redirect_to @product}
        format.js
      else
        flash[:warning] = t "create_fail"
        format.html {render @product}
      end
    end
  end

  def edit; end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html {redirect_to @product}
        format.js
      else
        flash[:danger] = "Delete fail"
        format.html {redirect_to @product}
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html {redirect_to @product}
        format.js
      else
        flash[:danger] = t ".update_fail"
        format.html {render :edit}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :product_id
  end

  def load_product
    @product = Product.find_by id: params[:product_id] if params[:product_id]
    render file: "public/404.html", layout: false unless @product
  end

  def load_comment
    @comment = @product.comments.find_by id: params[:id]
    render file: "public/404.html", layout: false unless @comment
  end
end
