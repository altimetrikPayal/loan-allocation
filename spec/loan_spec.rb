require_relative "../loan"

describe "Loan" do
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

  describe "#valid_for_investor?" do
    context "when the loan category is not in the investor's categories" do
      let(:investor) { { categories: ["retail"] } }
      let(:loan) { loans[0] }

      it "returns false" do
        expect(Loan.valid_for_investor?(loan, investor)).to be false
      end
    end

    context "when the loan risk band is not in the investor's risk bands" do
      let(:investor) { { risk_bands: ["A", "B"] } }
      let(:loan) { loans[2] }

      it "returns false" do
        expect(Loan.valid_for_investor?(loan, investor)).to be false
      end
    end

    context "when the loan amount is greater than the investor's funds" do
      let(:investor) { { funds: 500 } }
      let(:loan) { loans[0] }

      it "returns false" do
        expect(Loan.valid_for_investor?(loan, investor)).to be false
      end
    end

    context "when the loan amount is less than the investor's fund percentage" do
      let(:investor) { { funds: 1000, fund_criteria_in_percent: 50 } }
      let(:loan) { loans[0] }

      it "returns false" do
        expect(Loan.valid_for_investor?(loan, investor)).to be false
      end
    end

    context "when all the criteria are met" do
      let(:investor) { { categories: ["property"], risk_bands: ["A"], funds: 1000, fund_criteria_in_percent: nil } }
      let(:loan) { loans[0] }
      it "returns true" do
        expect(Loan.valid_for_investor?(loan, investor)).to be true
      end
    end
  end
end
