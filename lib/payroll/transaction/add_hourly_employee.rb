require_relative "add_employee_transaction"
require_relative "../employee"
require_relative "../classification/hourly_classification"
require_relative "../schedule/weekly_schedule"
require_relative "../method/payment_method"
require_relative "../payroll_database"

class AddHourlyEmployee < AddEmployeeTransaction
  def initialize(emp_id, name, address, hourly_rate)
    super(emp_id, name, address)
    @hourly_rate = hourly_rate
  end

  def execute
    employee = Employee.new(@emp_id, @name, @address)
    employee.classification = HourlyClassification.new(@hourly_rate)
    employee.schedule = WeeklySchedule.new
    employee.payment_method = HoldMethod.new

    PayrollDatabase.add_employee(employee)
  end
end
