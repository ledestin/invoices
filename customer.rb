require "active_support/core_ext/object/blank"
require_relative "initialize"

class Customer < Struct.new(:name, :companies)
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
