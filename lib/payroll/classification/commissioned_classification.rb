class CommissionedClassification
  attr_accessor :monthly_salary, :commission_rate

  def initialize(monthly_salary, commission_rate)
    @monthly_salary = monthly_salary
    @commission_rate = commission_rate
  end
end
