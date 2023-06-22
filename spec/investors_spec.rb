require 'rspec'

require_relative '../investors'

describe Investors do
  let(:loans) do
    [
      {
        "id": 1234567,
        "category": "property",
        "risk_band": "A",
        "amount": 1000
      },
      {
        "id": 2345678,
        "category": "retail",
        "risk_band": "A",
        "amount": 2000
      },
      {
        "id": 3456789,
        "category": "Rent",
        "risk_band": "A+",
        "amount": 300
      }
    ]
  end

  let(:investors) do
    [
      {
        "name": "Bob",
        "categories": ["property"],
        "risk_bands": ["A"],
        "funds": 50000,
        "fund_criteria_in_percent": nil,
        "risk_bands_criteria": "greater_than B"
      },
      {
        "name": "Susan",
        "categories": ["property", "retail"],
        "risk_bands": ["A", "B"],
        "funds": 20000,
        "fund_criteria_in_percent": nil,
        "risk_bands_criteria": nil
      },
      {
        "name": "George",
        "categories": ["Rent"],
        "risk_bands": [],
        "funds": 3000000,
        "fund_criteria_in_percent": 40,
        "risk_bands_criteria": "greater_than A"
      }
    ]
  end

  describe "#allocate_loan" do
    context "when there are loans and investors" do
      it "returns a dictionary mapping investors to the loans that they have been allocated" do
        result = Investors.new().allocate_loan(loans)
        expect(result).to eq({
          "Bob"=> 1234567,
          "Susan"=> 2345678,
          "George"=> 3456789
        })
      end
    end
  end
end
