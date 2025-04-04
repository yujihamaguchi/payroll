require_relative "add_employee_transaction"
require_relative "../employee"
require_relative "../classification/salaried_classification"
require_relative "../schedule/monthly_schedule"
require_relative "../method/payment_method"
require_relative "../payroll_database"

class AddSalariedEmployee < AddEmployeeTransaction
  def initialize(emp_id, name, address, monthly_salary)
    super(emp_id, name, address)
    @monthly_salary = monthly_salary
  end

  def execute
    employee = Employee.new(@emp_id, @name, @address)
    employee.classification = SalariedClassification.new(@monthly_salary)
    employee.schedule = MonthlySchedule.new
    employee.payment_method = HoldMethod.new

    PayrollDatabase.add_employee(employee)
  end
end
