require "spec_helper"
require_relative "../customer"
require_relative "../company"
require_relative "../location"

describe Company do
  include_context "data"

  describe "#invoice" do
    it "returns an invoice" do
      expect(spacex.invoice).to eq <<~INVOICE
        Company: SpaceX
        Locations:
        Florida: $40,000.00
        San Francisco: $40,000.00
        Hawaii: $10,000.00
        Total: $100,000.00
      INVOICE
    end
  end

  describe "#send_invoice" do
    it "sends invoice to the company itself by default" do
      expect(spacex.send_invoice).to eq "Sending to SpaceX"
    end

    it "sends invoice to the customer if so instructed" do
      spacex.invoice_to :customer
      expect(spacex.send_invoice).to eq "Sending to Elon Musk"
    end

    it "can be setup to send invoices to different recipients" do
      spacex.invoice_to :customer

      expect(spacex.send_invoice).to eq "Sending to Elon Musk"
      expect(tesla.send_invoice).to eq "Sending to Tesla"
    end
  end
end
