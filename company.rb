require "money"
require_relative "bill"

class Company
  attr_accessor :name, :locations, :customer
  attr_reader :invoice_to

  def initialize
    @invoice_to = :self
  end

  def invoice_to(new_receiver)
    @invoice_to = new_receiver
  end

  def invoice
    invoice = <<~INVOICE
      Company: #{name}
      Locations:
      #{locations.map(&:invoice).join("\n")}
      Total: #{amount_to_pay.format}
    INVOICE
  end

  def send_invoice
    "Sending to #{receiver.name}"
  end

  private

  def receiver
    return self if @invoice_to == :self
    return customer if @invoice_to == :customer
  end

  def amount_to_pay
    Bill.for self
  end
end
