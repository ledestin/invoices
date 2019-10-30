require "active_support/core_ext/object/blank"
require_relative "initialize"

class Customer < Struct.new(:name, :companies)
  def invoices
    return [] unless companies.present?

    invoice = <<~INVOICE
      Customer: #{name}

      #{companies.map(&:invoice).join("\n")}
    INVOICE
    [invoice.chomp]
  end
end
