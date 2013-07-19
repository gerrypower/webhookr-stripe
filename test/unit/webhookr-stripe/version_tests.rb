$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'

describe Webhookr::Stripe do
  it "must be defined" do
    Webhookr::Stripe::VERSION.wont_be_nil
  end
end