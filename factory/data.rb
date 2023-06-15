module Sample
  # Loans
  LOANS = [
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

  # Investors
  INVESTORS = [
    {
      "name": "Bob",
      "categories": ["property"],
      "risk_bands": ["A", "B"],
      "funds": 500,
      "fund_criteria": nil,
      "risk_bands_criteria": "greater_than B"
    },
    {
      "name": "Susan",
      "categories": ["property", "retail"],
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
