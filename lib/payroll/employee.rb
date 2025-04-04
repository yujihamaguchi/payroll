class Employee
  attr_accessor :emp_id, :name, :address, :classification, :schedule, :payment_method

  def initialize(emp_id, name, address)
    @emp_id = emp_id
    @name = name
    @address = address
  end
end
