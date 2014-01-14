# Webhookr::Stripe
[![Build Status](https://travis-ci.org/gerrypower/webhookr-stripe.png?branch=master)](https://travis-ci.org/gerrypower/webhookr-stripe)
[![Dependency Status](https://gemnasium.com/gerrypower/webhookr-stripe.png)](https://gemnasium.com/gerrypower/webhookr-stripe)
[![Code Climate](https://codeclimate.com/github/gerrypower/webhookr-stripe.png)](https://codeclimate.com/github/gerrypower/webhookr-stripe)
[![Coverage Status](https://coveralls.io/repos/gerrypower/webhookr-stripe/badge.png)](https://coveralls.io/r/gerrypower/webhookr-stripe)

This gem is a plugin for [Webhookr](https://github.com/zoocasa/webhookr) that enables
your application to accept [webhooks from Stripe](https://stripe.com/docs/webhooks).

## Installation

Add this line to your application's Gemfile:

    gem 'webhookr-stripe'

Or install it yourself:

    $ gem install webhookr-stripe

[webhookr](https://github.com/zoocasa/webhookr) is installed as a dependency of webhookr-stripe. If you have not [setup Webhookr](https://github.com/zoocasa/webhookr#usage--setup), do so now:

```console
rails g webhookr:add_route
```

## Usage

Once you have the gem installed run the generator to add the code to your initializer.
An initializer will be created if you do not have one.

```console
rails g webhookr:stripe:init *initializer_name* -s
```

Run the generator to create an example file to handle stripe webhooks.

```console
rails g webhookr:stripe:example_hooks
```

Or create a stripe handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class StripeHooks
  def on_charge_succeeded(incoming)
    # Your custom logic goes here.
    charge = incoming.payload
    puts("charge.succeeded: (#{charge})")
  end
end
```

For a complete list of events, and the payload format, see below.

Edit config/initializers/*initializer_name* and change the commented line to point to
your custom Stripe event handling class. If your class was called *StripeHooks*
the configuration line would look like this:

```ruby
  Webhookr::Stripe::Adapter.config.callback = StripeHooks
```

To see the list of Stripe URLs your application can use when you configure
stripe webhooks,
run the provided webhookr rake task:

```console
rake webhookr:services
```

Example output:

```console
stripe:
  GET	/webhookr/events/stripe/19xl64emxvn
  POST	/webhookr/events/stripe/19xl64emxvn
```

## Stripe Events & Payload

### Events

All webhook events are supported. For further information on these events, see the
[stripe documentation](https://stripe.com/docs/api#event_types).

<table>
  <tr>
    <th>Stripe Event</th>
    <th>Event Handler</th>
  </tr>
  <tr>
    <td>account.updated</td>
    <td>on_account_updated(incoming)</td>
  </tr>
  <tr>
    <td>charge.succeeded</td>
    <td>on_charge_succeeded(incoming)</td>
  </tr>
  <tr>
    <td>charge.failed</td>
    <td>on_charge_failed(incoming)</td>
  </tr>
  <tr>
    <td>charge.refunded</td>
    <td>on_charge_refunded(incoming)</td>
  </tr>
  <tr>
    <td>charge.dispute.created</td>
    <td>on_charge_dispute_created(incoming)</td>
  </tr>
  <tr>
    <td>charge.dispute.updated</td>
    <td>on_charge_dispute_updated(incoming)</td>
  </tr>
  <tr>
    <td>charge.dispute.closed</td>
    <td>on_charge_dispute_closed(incoming)</td>
  </tr>
  <tr>
    <td>coupon.created</td>
    <td>on_coupon_created(incoming)</td>
  </tr>
  <tr>
    <td>coupon.deleted</td>
    <td>on_coupon_deleted(incoming)</td>
  </tr>
  <tr>
    <td>customer.created</td>
    <td>on_customer_created(incoming)</td>
  </tr>
  <tr>
    <td>customer.updated</td>
    <td>on_customer_updated(incoming)</td>
  </tr>
  <tr>
    <td>customer.deleted</td>
    <td>on_customer_deleted(incoming)</td>
  </tr>
  <tr>
    <td>customer.discount.created</td>
    <td>on_customer_discount_created(incoming)</td>
  </tr>
  <tr>
    <td>customer.discount.updated</td>
    <td>on_customer_discount_updated(incoming)</td>
  </tr>
  <tr>
    <td>customer.discount.deleted</td>
    <td>on_customer_discount_deleted(incoming)</td>
  </tr>
  <tr>
    <td>customer.subscription.created</td>
    <td>on_customer_subscription_created(incoming)</td>
  </tr>
  <tr>
    <td>customer.subscription.updated</td>
    <td>on_customer_subscription_updated(incoming)</td>
  </tr>
  <tr>
    <td>customer.subscription.deleted</td>
    <td>on_customer_subscription_deleted(incoming)</td>
  </tr>
  <tr>
    <td>invoice.created</td>
    <td>on_invoice_created(incoming)</td>
  </tr>
  <tr>
    <td>invoice.updated</td>
    <td>on_invoice_updated(incoming)</td>
  </tr>
  <tr>
    <td>invoice.payment_succeeded</td>
    <td>on_invoice_payment_succeeded(incoming)</td>
  </tr>
  <tr>
    <td>invoice.payment_failed</td>
    <td>on_invoice_payment_failed(incoming)</td>
  </tr>
  <tr>
    <td>invoiceitem.created</td>
    <td>on_invoiceitem_created(incoming)</td>
  </tr>
  <tr>
    <td>invoiceitem.updated</td>
    <td>on_invoiceitem_updated(incoming)</td>
  </tr>
  <tr>
    <td>invoiceitem.deleted</td>
    <td>on_invoiceitem_deleted(incoming)</td>
  </tr>
  <tr>
    <td>plan.created</td>
    <td>on_plan_created(incoming)</td>
  </tr>
  <tr>
    <td>plan.updated</td>
    <td>on_plan_updated(incoming)</td>
  </tr>
  <tr>
    <td>plan.deleted</td>
    <td>on_plan_deleted(incoming)</td>
  </tr>
  <tr>
    <td>transfer.created</td>
    <td>on_transfer_created(incoming)</td>
  </tr>
  <tr>
    <td>transfer.updated</td>
    <td>on_transfer_updated(incoming)</td>
  </tr>
  <tr>
    <td>transfer.paid</td>
    <td>on_transfer_paid(incoming)</td>
  </tr>
  <tr>
    <td>transfer.failed</td>
    <td>on_transfer_failed(incoming)</td>
  </tr>
</table>

### Payload

The payload is the full payload data from as per the
[stripe documentation](https://stripe.com/docs/api#event_types), converted to an OpenStruct
for ease of access. Examples can be found in the example hook file.

### <a name="supported_services"></a>Supported Service - stripe

* [https://stripe.com/docs/webhooks](stripe - version: 2013-07-05)

## <a name="works_with"></a>Works with:

webhookr-stripe works with Rails 3.1, 3.2 and 4.0, and has been tested on the following Ruby
implementations:

* 2.0.0

Pending:

* 1.9.3
* jruby-19mode

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr-stripe', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr-stripe', '0.0.1'

## License

webhookr-stripe is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)
