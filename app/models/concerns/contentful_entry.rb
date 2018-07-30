module ContentfulEntry
  extend ActiveSupport::Concern

  class_methods do
    attr_accessor :content_type
    attr_accessor :scope

    def type(type)
      self.content_type = type
    end

    def all(params = {})
      params.merge!(self.scope.call(self).params) if self.scope

      ContentfulApi::Connection.entries(content_type, params)
    end

    def find(id)
      ContentfulApi::Connection.entry(content_type, id).try(:first)
    end

    def find_by(key, value)
      where(key => value).all.try(:first)
    end

    def default_scope(lambda)
      self.scope = lambda
    end

    def paginate(page_number, limit, params = {})
      offset = (page_number.to_i - 1) * limit

      filter(params.merge(limit: limit, skip: offset))
    end

    def where(fields = {}, params = {})

      fields.each do |key, value|
        params["fields.#{key.to_s.camelize(:lower)}"] = value
      end

      filter(params)
    end

    def children_of(entry, params = {})
      filter(params.merge("fields.#{entry.class.content_type.to_s.pluralize}.sys.id" => entry.id))
    end

    def order(key, asc = 'asc', params = {})

      if asc.to_s == 'desc'
        key = "-sys.#{key.to_s.camelize(:lower)}"
      else
        key = "sys.#{key.to_s.camelize(:lower)}"
      end

      filter(params.merge(order: key))
    end

    def limit(number, params = {})
      filter(params.merge(limit: number))
    end

    private

    def filter(params)
      ContentfulApi::ParamsProxy.new(self, params)
    end

  end

end