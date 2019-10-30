Hello!

While I've written code for the test, the main purpose of the code was for me to
understand how to design the app. It's a WIP and could be improved.

## Invoicing

I see two cross-cutting concerns in invoicing:
* The ability to invoice different entities.
* The ability to have standalone/merged invoices. E.g. company invoices are
  standalone, but locations can be merged into customer invoice.

### Use case 1

The companies get settings `invoice_to: :self` (that's the default) and
`standalone_invoice: true`. So, the separate invoices would be sent to the
companies themselves.

### Use case 2

Companies A and B get settings `invoice_to: :customer`, and C is left
with `invoice_to :self` by default.

### Use case 3

Not that different from the use case 2.

### Use case 4

All corresponding locations get settings `invoice_to: :customer` and
`standalone_invoice: false`. Guess, it can be figured out on the company level
that if there are no locations invoicing to company, there's no invoice to be
done.


## Billing

I envisioned billing as a black box that knows how much to charge locations and
maybe companies.

For billing periods to work, I think that history of settings is needed.
Suppose, processing invoices takes place on the first day of each month.
Customer might change invoicing settings on that day, and they should apply on
the next billing period. But the old settings are needed for processing the
previous month's invoices. It can't be guaranteed that the processing takes
place during the billing period it's processing (think broken invoice
processing, for example).

## Invoice building

It might be a good idea to extract presenters or something for generating
invoice bodies.

## Settings

Default `invoice_to` settings are hardcoded at the moment, but could be taken
from customer settings.
