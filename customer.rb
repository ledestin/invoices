require "active_support/core_ext/object/blank"
require_relative "initialize"

class Customer
  attr_accessor :name
  attr_reader :companies

  def companies=(value)
    @companies = value
    @companies.each do |company|
      company.customer = self
    end
  end

  def invoice
    <<~INVOICE
      Customer: #{name}

      Locations:
      #{locations_invoicing_to_customer.map(&:invoice).join("\n")}
    INVOICE
  end

  private

  def locations_invoicing_to_customer
    companies.flat_map(&:locations).select do
      |location| location.invoicing_to == :customer
    end
  end
end
