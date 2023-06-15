require_relative "../loan_allocation"

describe 'loan_allocation' do
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
        "risk_bands": ["A", "B"],
        "funds": 1000,
        "fund_criteria": nil,
        "risk_bands_criteria": "greater_than B"
      },
      {
        "name": "Susan",
        "categories": ["retail"],
        "risk_bands": ["A", "B"],
        "funds": 20000,
        "fund_criteria": nil,
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

  it "allocates loans to investors" do
    expected_loan_allocations = [{:amount=>1000,
                                  :category=>"property",
                                  :id=>1234567,
                                  :investor=>
                                    {:categories=>["property"],
                                     :fund_criteria=>nil,
                                     :funds=>1000,
                                     :name=>"Bob",
                                     :risk_bands=>["A", "B"],
                                     :risk_bands_criteria=>"greater_than B"},
                                   :risk_band=>"A"},
                                  {:amount=>2000,
                                   :category=>"retail",
                                   :id=>2345678,
                                   :investor=>
                                    {:categories=>["retail"],
                                     :fund_criteria=>nil,
                                     :funds=>20000,
                                     :name=>"Susan",
                                     :risk_bands=>["A", "B"],
                                     :risk_bands_criteria=>nil},
                                   :risk_band=>"A"},
                                  {:amount=>300,
                                   :category=>"Rent",
                                   :id=>3456789,
                                   :investor=>
                                    {:categories=>["Rent"],
                                     :fund_criteria_in_percent=>40,
                                     :funds=>3000000,
                                     :name=>"George",
                                     :risk_bands=>[],
                                     :risk_bands_criteria=>"greater_than A"},
                                   :risk_band=>"A+"}]

    actual_loan_allocations = allocate_loans(loans, investors)

    expect(actual_loan_allocations).to eq(expected_loan_allocations)
  end

  it "does not allocate loans to investors who do not meet the criteria" do
    investors[0][:funds] = 500
    actual_loan_allocations = allocate_loans(loans, investors)
    expect(actual_loan_allocations[0][:investor]).to be nil
  end

end
