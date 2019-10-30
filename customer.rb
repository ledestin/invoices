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

  def invoices
    return [] unless companies.present?

    companies.map do |company|
      invoice company
    end
  end

  private

  def invoice(company)
    invoice = <<~INVOICE
      Customer: #{name}

      #{company.invoice}
    INVOICE
    invoice.chomp
  end
end
