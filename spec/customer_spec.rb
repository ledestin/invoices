require "spec_helper"
require_relative "../customer"
require_relative "../company"
require_relative "../location"

describe Customer do
  include_context "data"

  describe "#invoice" do
    before do
      spacex.invoice_all_locations_to :customer
      tesla.invoice_all_locations_to :customer
    end

    it "returns invoice that contains all locations" do
      expect(elon_musk.invoice).to eq <<~INVOICE
        Customer: Elon Musk

        Locations:
        Florida: $40,000.00
        San Francisco: $40,000.00
        Hawaii: $10,000.00
        Palo Alto: $100,000.00
        Detroit: $100,000.00
      INVOICE
    end

    it "returns invoice that doesn't contain Hawaii that invoices to itself" do
      hawaii.invoice_to :self

      expect(elon_musk.invoice).to eq <<~INVOICE
        Customer: Elon Musk

        Locations:
        Florida: $40,000.00
        San Francisco: $40,000.00
        Palo Alto: $100,000.00
        Detroit: $100,000.00
      INVOICE
    end
  end
end
