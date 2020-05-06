module PaperTrail
  module Background
    module Sidekiq
      def perform(version_class, attributes, event)
        attrs = JSON.load(attributes)
        attrs.symbolize_keys!
        attrs.delete(:item)
        attrs[:item] = attrs[:item_type].constantize.find_by(id: attrs[:item_id])
        version = version_class.constantize.create!(attrs)
      end
    end
  end
end
