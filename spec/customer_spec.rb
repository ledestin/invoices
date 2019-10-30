require "spec_helper"
require_relative "../customer"
require_relative "../company"
require_relative "../location"

describe Customer do
  let(:florida) { build :location, address: "Florida" }
  let(:san_francisco) { build :location, address: "San Francisco" }
  let(:hawaii) { build :location, address: "Hawaii" }
  let(:paolo_alto) { build :location, address: "Paolo Alto" }
  let(:detroit) { build :location, address: "Detroit" }

  let(:spacex) do
    build :company, name: "SpaceX", locations: [florida, san_francisco, hawaii]
  end
  let(:tesla) do
    build :company, name: "Tesla", locations: [paolo_alto, detroit]
  end
  let(:customer_without_companies) { build :customer }
  let(:customer_with_one_company) { build :customer, companies: [spacex] }
  let(:customer_with_two_companies) do
    build :customer, companies: [spacex, tesla]
  end

  describe "#invoice" do
    before :each do
      allow(Bill).to receive(:for) do |company_or_location|
        {
          florida => Money.new(40_000_00, "USD"),
          san_francisco => Money.new(40_000_00, "USD"),
          hawaii => Money.new(10_000_00, "USD"),
          spacex => Money.new(100_000_00, "USD"),
          paolo_alto => Money.new(100_000_00, "USD"),
          detroit => Money.new(100_000_00, "USD"),
          tesla => Money.new(200_000_00, "USD")
        }[company_or_location]
      end
    end

    it "returns an empty array if there are no companies defined" do
      expect(customer_without_companies.invoices).to eq []
    end

    it "return an invoice if there's a company defined" do
      expect(customer_with_one_company.invoices.first).to eq <<~INVOICE
        Customer: Elon Musk

        Company: SpaceX
        Locations:
        Florida: $40,000.00
        San Francisco: $40,000.00
        Hawaii: $10,000.00
        Subtotal: $100,000.00
      INVOICE
    end

    it "return an invoice if there are 2 companies defined" do
      expect(customer_with_two_companies.invoices.first).to eq <<~INVOICE
        Customer: Elon Musk

        Company: SpaceX
        Locations:
        Florida: $40,000.00
        San Francisco: $40,000.00
        Hawaii: $10,000.00
        Subtotal: $100,000.00

        Company: Tesla
        Locations:
        Paolo Alto: $100,000.00
        Detroit: $100,000.00
        Subtotal: $200,000.00
      INVOICE
    end
  end
end
