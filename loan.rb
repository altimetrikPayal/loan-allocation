class Loan
  attr_accessor :loans

  RISK_BAND = %w(A+ A B C D E)

  def initialize
    # initialize loans with some data
    @loans = [
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

  def self.valid_for_investor? loan, investor
    valid = true
    valid = false if !Loan.category_exist?(investor, loan) #category check
    valid = false if !Loan.valid_risk_band?(investor, loan) #risk band check
    valid = false if !Loan.valid_fund?(investor, loan) #fund check
    return valid
  end

  def self.category_exist? investor, loan
    !investor[:categories].nil? && investor[:categories].include?(loan[:category]) #category check
  end

  def self.risk_bands_category_exist? investor, loan
    investor[:risk_bands_criteria].nil? && !investor[:risk_bands].nil? && investor[:risk_bands].include?(loan[:risk_band]) #risk_bands check
  end

  def self.efficient_fund? investor, loan
    !investor[:funds].nil? && ( investor[:funds] > loan[:amount] )#fund check
  end

  def Loan.efficient_percent_in_fund? investor, loan
    investor[:fund_criteria_in_percent].nil? || Loan.efficient_fund_percent?(investor, loan)
  end

  def self.efficient_fund_percent? investor, loan
    (loan[:amount] < Loan.percent_of(investor[:funds], investor[:fund_criteria_in_percent]))
  end

  def self.risk_bands_crieteria_exist? investor, loan
    !investor[:risk_bands_criteria].nil? && Loan.risk_band_criteria_match?(investor, loan)
  end

  def self.valid_risk_band? investor, loan
    Loan.risk_bands_category_exist?(investor, loan) || Loan.risk_bands_crieteria_exist?(investor, loan)
  end

  def self.risk_band_criteria_match? investor, loan
    condition = investor[:risk_bands_criteria].split(" ")[0]
    conditional_risk_band = investor[:risk_bands_criteria].split(" ")[1]
    index = RISK_BAND.index(conditional_risk_band)

    case condition
    when "greater_than"
      filtered_risk_band = RISK_BAND[0...index]
    when "less_than"
      filtered_risk_band = RISK_BAND[index...RISK_BAND.length]
    end

    filtered_risk_band.include?(loan[:risk_band])
  end

  def self.valid_fund? investor,loan
    Loan.efficient_fund?(investor, loan) || Loan.efficient_percent_in_fund?(investor, loan)
  end

  private

  def self.percent_of(amount, percent)
    (amount.to_f * percent.to_f) / 100.0
  end

end
