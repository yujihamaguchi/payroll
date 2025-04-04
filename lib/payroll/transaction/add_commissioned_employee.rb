require_relative "add_employee_transaction"
require_relative "../employee"
require_relative "../classification/commissioned_classification"
require_relative "../schedule/biweekly_schedule"
require_relative "../method/payment_method"
require_relative "../payroll_database"

class AddCommissionedEmployee < AddEmployeeTransaction
  def initialize(emp_id, name, address, monthly_salary, commission_rate)
    super(emp_id, name, address)
    @monthly_salary = monthly_salary
    @commission_rate = commission_rate
  end

  def execute
    employee = Employee.new(@emp_id, @name, @address)
    employee.classification = CommissionedClassification.new(@monthly_salary, @commission_rate)
    employee.schedule = BiweeklySchedule.new
    employee.payment_method = HoldMethod.new

    PayrollDatabase.add_employee(employee)
  end
end
