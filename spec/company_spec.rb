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
end
