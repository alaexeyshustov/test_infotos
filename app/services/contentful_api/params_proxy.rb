module ContentfulApi
  class ParamsProxy
    attr_reader :params
    attr_reader :relation

    def initialize(relation, params)
      @relation = relation
      @params   = params
    end

    def method_missing(method, *args, &block)
      args << self.params
      @relation.send(method, *args, &block)
    end

  end
end
