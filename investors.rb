require_relative './loan'
require 'pry'
class Investors
  attr_accessor :investors
  attr_reader :investor_funds

  def initialize
    #Initialize investors with some data
    @investors = [
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
    @investor_funds = {}
  end

  def allocate_loan loans
    # Iterate over the loans and allocate them to investors.
    loans.each do |loan|
      # Iterate investor who is willing to invest in this loan.
      investors.each do |investor|

        if Loan.valid_for_investor? loan, investor
          investor_funds[investor[:name]] = loan[:id]
        end
      end
    end
    # Return a dictionary mapping investors to the loans that they have been allocated (map investor with loan ID).
    investor_funds
  end

  loan = Loan.new
  print Investors.new().allocate_loan(loan.loans)
end
