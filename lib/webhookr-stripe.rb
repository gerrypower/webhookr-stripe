require "webhookr"
require "webhookr-stripe/version"
require "webhookr/ostruct_utils"

module Webhookr
  module Stripe
    class Adapter
      SERVICE_NAME = "stripe"
      EVENT_KEY = "type"
      PAYLOAD_KEY = "data"
      OBJECT_KEY = "object"

      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME,
            convert_periods_to_underscores(p.fetch(EVENT_KEY)),
            OstructUtils.to_ostruct(p)[PAYLOAD_KEY][OBJECT_KEY]
          ) if assert_valid_packet(p)
        end
      end

      private

      def convert_periods_to_underscores(event)
        return if event.nil?
        event.gsub(".", "_")
      end

      def parse(raw_response)
        begin
          ActiveSupport::JSON.decode(
            CGI.unescape(raw_response)
          )
        rescue Exception => e
          raise InvalidPayloadError.new(e)
        end
      end

      def assert_valid_packet(packet)
        raise(Webhookr::InvalidPayloadError, "Unknown event #{packet[EVENT_KEY]}") unless packet[EVENT_KEY]
        raise(Webhookr::InvalidPayloadError, "No data in the response") unless packet[PAYLOAD_KEY] && packet[PAYLOAD_KEY][OBJECT_KEY]
        true
      end

    end
  end
end
