class Article < Contentful::Entry
  include ContentfulEntry

  DEFAULT_LIMIT = 8

  type          :article
  default_scope ->(model) { model.where(available_on: 'infotoss.com').order(:updated_at, :desc).limit(DEFAULT_LIMIT) }

  attr_accessor :category_id

  def category
    @category ||= Category.find(self.category_id)
  end

end