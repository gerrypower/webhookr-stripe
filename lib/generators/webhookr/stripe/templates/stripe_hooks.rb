class StripeHooks

  # All 'on_' handlers are optional. Omit any you do not require.
  # Details on the payload structure: http://help.stripe.com/entries/24466132-Webhook-Format
  #
  # Note: You are responsible for checking 'livemode' on incoming payloads.
  # See https://stripe.com/docs/webhooks#receiving-application-webhooks
  #

  def on_account_updated(incoming)
    account = incoming.payload
    puts("account.updated: (#{account})")
  end

  def on_charge_succeeded(incoming)
    charge = incoming.payload
    puts("charge.succeeded: (#{charge})")
  end

  def on_charge_failed(incoming)
    charge = incoming.payload
    puts("charge.failed: (#{charge})")
  end

  def on_charge_refunded(incoming)
    charge = incoming.payload
    puts("charge.refunded: (#{charge})")
  end

  def on_charge_dispute_created(incoming)
    dispute = incoming.payload
    puts("charge.dispute.created: (#{dispute})")
  end

  def on_charge_dispute_updated(incoming)
    dispute = incoming.payload
    puts("charge.dispute.updated: (#{dispute})")
  end

  def on_charge_dispute_closed(incoming)
    dispute = incoming.payload
    puts("charge.dispute.closed: (#{dispute})")
  end

  def on_coupon_created(incoming)
    coupon = incoming.payload
    puts("coupon.created: (#{coupon})")
  end

  def on_coupon_deleted(incoming)
    coupon = incoming.payload
    puts("coupon.deleted: (#{coupon})")
  end

  def on_customer_created(incoming)
    customer = incoming.payload
    puts("customer.created: (#{customer})")
  end

  def on_customer_updated(incoming)
    customer = incoming.payload
    puts("customer.updated: (#{customer})")
  end

  def on_customer_deleted(incoming)
    customer = incoming.payload
    puts("customer.deleted: (#{customer})")
  end

  def on_customer_discount_created(incoming)
    discount = incoming.payload
    puts("customer.discount.created: (#{discount})")
  end

  def on_customer_discount_updated(incoming)
    discount = incoming.payload
    puts("customer.discount.updated: (#{discount})")
  end

  def on_customer_discount_deleted(incoming)
    discount = incoming.payload
    puts("customer.discount.deleted: (#{discount})")
  end

  def on_customer_subscription_created(incoming)
    subscription = incoming.payload
    puts("customer.subscription.created: (#{subscription})")
  end

  def on_customer_subscription_updated(incoming)
    subscription = incoming.payload
    puts("customer.subscription.updated: (#{subscription})")
  end

  def on_customer_subscription_deleted(incoming)
    subscription = incoming.payload
    puts("customer.subscription.deleted: (#{subscription})")
  end

  def on_invoice_created(incoming)
    invoice = incoming.payload
    puts("invoice.created: (#{invoice})")
  end

  def on_invoice_updated(incoming)
    invoice = incoming.payload
    puts("invoice.updated: (#{invoice})")
  end

  def on_invoice_payment_succeeded(incoming)
    invoice = incoming.payload
    puts("invoice.payment_succeeded: (#{invoice})")
  end

  def on_invoice_payment_failed(incoming)
    invoice = incoming.payload
    puts("invoice.payment_failed: (#{invoice})")
  end

  def on_invoiceitem_created(incoming)
    invoiceitem = incoming.payload
    puts("invoiceitem.created: (#{invoiceitem})")
  end

  def on_invoiceitem_updated(incoming)
    invoiceitem = incoming.payload
    puts("invoiceitem.updated: (#{invoiceitem})")
  end

  def on_invoiceitem_deleted(incoming)
    invoiceitem = incoming.payload
    puts("invoiceitem.deleted: (#{invoiceitem})")
  end

  def on_plan_created(incoming)
    plan = incoming.payload
    puts("plan.created: (#{plan})")
  end

  def on_plan_updated(incoming)
    plan = incoming.payload
    puts("plan.updated: (#{plan})")
  end

  def on_plan_deleted(incoming)
    plan = incoming.payload
    puts("plan.deleted: (#{plan})")
  end

  def on_transfer_created(incoming)
    transfer = incoming.payload
    puts("transfer.created: (#{transfer})")
  end

  def on_transfer_updated(incoming)
    transfer = incoming.payload
    puts("transfer.updated: (#{transfer})")
  end

  def on_transfer_paid(incoming)
    transfer = incoming.payload
    puts("transfer.paid: (#{transfer})")
  end

  def on_transfer_failed(incoming)
    transfer = incoming.payload
    puts("transfer.failed: (#{transfer})")
  end
end
