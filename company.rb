require "money"
require_relative "bill"

class Company < Struct.new(:name, :locations)
  def invoice
    invoice = <<~INVOICE
      Company: #{name}
      Locations:
      #{locations.map(&:invoice).join("\n")}
      Total: #{amount_to_pay.format}
    INVOICE
  end

  private

  def amount_to_pay
    Bill.for self
  end
end
