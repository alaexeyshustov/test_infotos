class Category < Contentful::Entry
  include ContentfulEntry

  type          :category
  default_scope ->(model) { model.where(available_on: 'infotoss.com').order(:updated_at, :desc) }


  def articles
    Article.children_of(self)
  end

end