RSpec.shared_context "data" do
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
end
