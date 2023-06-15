require './factory/data'
include Sample

RISK_BAND = %w(A+ A B C D E)

def percent_of(amount, percent)
  (amount.to_f * percent.to_f) / 100.0
end


def allocate_loans(loans, investors)

  # Create a dictionary mapping investors to the amount of money that they have available to invest.
  investor_funds = {}
  investors.each do |investor|
    fund =  percent_of(investor[:funds], investor[:fund_criteria_in_percent]) unless investor[:fund_criteria_in_percent].nil?
    investor_funds[investor] = fund.nil? ? investor[:funds] : fund
  end

  # Iterate over the loans and allocate them to investors.
  loans.each do |loan|
    # Find an investor who is willing to invest in this loan.
    investors.each do |investor|
      if category_exist?(investor,loan) && risk_band_exist?(investor,loan)
        
        # Check if the investor has any risk band criteria.
        break if !risk_band_criteria_match?(investor, loan) if !investor[:risk_bands_criteria].nil?
        
        # Check if the investor has enough money to invest in this loan.
        if has_valid_fund?(investor_funds, investor, loan)
          # Allocate the loan to the investor.
          investor_funds[investor] -= loan[:amount]
          loan[:investor] = investor
          break
        end
      end
    end
  end

  # Return a dictionary mapping investors to the loans that they have been allocated.
  return loans
end


def category_exist? investor, loan
  investor[:categories].include?(loan[:category])
end

def risk_band_exist? investor, loan
  investor[:risk_bands].include?(loan[:risk_band]) || !investor[:risk_bands_criteria].nil?
end

def risk_band_criteria_match? investor, loan
  condition = investor[:risk_bands_criteria].split(" ")[0]
  conditional_risk_band = investor[:risk_bands_criteria].split(" ")[1]
  index = RISK_BAND.index(conditional_risk_band)

  case condition

  when "greater_than"
    filtered_risk_band = RISK_BAND[0...index]
    filtered_risk_band.include?(loan[:risk_band])
  when "less_than"
    filtered_risk_band = RISK_BAND[index...RISK_BAND.length]
    filtered_risk_band.include?(loan[:risk_band])
  end

end

def has_valid_fund? investor_funds, investor, loan
  investor_funds[investor] >= loan[:amount]
end

puts allocate_loans(Sample::LOANS, Sample::INVESTORS)
