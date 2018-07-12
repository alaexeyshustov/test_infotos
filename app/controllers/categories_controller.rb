class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find_by(:title, params[:id])
    render_404 unless @category

    @articles = paginate @category.articles
  end

  private

  def paginate(collection)
    collection = collection.paginate(params[:page] || 1, params[:limit] || Article::DEFAULT_LIMIT).all
    Kaminari.paginate_array(collection.items, limit: collection.limit, offset: collection.skip, total_count: collection.total)
  end
end
