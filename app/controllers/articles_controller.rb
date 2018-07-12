class ArticlesController < ApplicationController

  def show
    @article = Article.find_by(:slug, params[:id])
    render_404 unless @article
  end

end
