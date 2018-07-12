require 'forwardable'

module ContentfulApi
  class Connection
    include Singleton

    class << self
      extend Forwardable
      def_delegators :instance, :entries, :entry
    end

    attr_reader :api_client

    def initialize
      config = YAML.load(ERB.new(File.read(Rails.root.join('config', 'contentful.yml'))).result).with_indifferent_access

      @api_client = Contentful::Client.new(
          space: config[:space_id],
          access_token: config[:access_token],
          max_include_resolution_depth: 1,
          entry_mapping: {
              'category' => Category,
              'article'  => Article,
          }
      )
    end

    def entries(content_type, params = {})
      params.merge!(content_type: content_type.to_s)

      cache(params) do
        Rails.logger.warn("Api request: #{params}")
        api_client.entries(params)
      end
    end

    def entry(content_type, id)
      params = { content_type: content_type.to_s, 'sys.id' => id }
      cache(params) do
        Rails.logger.warn("Api request: #{params}")
        api_client.entries(params)
      end
    end

    private

    def cache(params, &block)
      key = key_from_params(params)

      Rails.cache.fetch(key, expires_in: 10.minutes , &block)
    end

    def key_from_params(params)
      params.map {|k,v| "#{k}_#{v}"}.join(':')
    end

  end
end