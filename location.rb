class Location
  attr_accessor :company, :address

  def initialize
    @invoice_to = :company
  end

  def invoice
    "#{address}: #{amount_to_pay.format}"
  end

  def invoice_to(new_receiver)
    @invoice_to = new_receiver
  end

  def invoicing_to
    @invoice_to
  end

  def amount_to_pay
    Bill.for self
  end
end
