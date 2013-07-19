
$: << File.join(File.dirname(__FILE__), "..")
require 'test_helper'

describe Webhookr::Stripe::Adapter do

  before do
    @event_type = "charge_succeeded"
    @blort_value = "blort_equals_100"
  end

  def valid_response
    '{ "created": 1326853478,
        "livemode": false,
        "id": "evt_00000000000000",
        "type": "charge.succeeded",
        "object": "event",
        "data":{
          "object": { "blort": "' + @blort_value + '" }
        }
      }'
  end

  def no_event_type_response
    '{ "created": 1326853478,
        "livemode": false,
        "id": "evt_00000000000000",
        "object": "event",
        "data":{
          "object": { "blort": "' + @blort_value + '" }
        }
      }'
  end

  def no_data_response
    '{ "created": 1326853478,
        "livemode": false,
        "id": "evt_00000000000000",
        "type": "charge.succeeded",
        "object": "event"
      }'
  end

  describe "the class" do

    subject { Webhookr::Stripe::Adapter }

    it "must support process" do
      subject.must_respond_to(:process)
    end

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(valid_response)
      }.must_be_silent
    end

  end

  describe "the instance" do

    subject { Webhookr::Stripe::Adapter.new }

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(valid_response)
      }.must_be_silent
    end

    it "should raise Webhookr::InvalidPayloadError for no packet" do
      lambda {
        subject.process("")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing event type" do
      lambda {
        subject.process(no_event_type_response)
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing data packet" do
      lambda {
        subject.process(no_data_response)
      }.must_raise(Webhookr::InvalidPayloadError)
    end

  end

  describe "it's response" do
    before do
      @adapter = Webhookr::Stripe::Adapter.new
    end

    subject { @adapter.process(valid_response).first }

    it "must respond to service_name" do
      subject.must_respond_to(:service_name)
    end

    it "should return the correct service name" do
      assert_equal(Webhookr::Stripe::Adapter::SERVICE_NAME, subject.service_name)
    end

    it "must respond to event_type" do
      subject.must_respond_to(:event_type)
    end

    it "should return the correct event type" do
      assert_equal(@event_type, subject.event_type)
    end

    it "must respond to payload" do
      subject.must_respond_to(:payload)
    end

    it "must respond to payload.blort" do
      subject.payload.must_respond_to(:blort)
    end

    it "should return the correct data packet" do
      assert_equal(@blort_value, subject.payload.blort)
    end
  end

end
