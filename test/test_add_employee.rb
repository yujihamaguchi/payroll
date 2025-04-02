require "test_helper"

class AddEmployeeTest < Minitest::Test
  def test_add_hourly_employee
    emp_id = 1
    name = "John Doe"
    address = "123 Main St"
    hourly_rate = 15.0

    transaction = AddHourlyEmployee.new(emp_id, name, address, hourly_rate)
    transaction.execute

    employee = PayrollDatabase.get_employee(emp_id)
    assert_equal name, employee.name
    assert_equal address, employee.address
    assert_instance_of HourlyClassification, employee.classification
    assert_equal hourly_rate, employee.classification.hourly_rate
    assert_instance_of WeeklySchedule, employee.schedule
    assert_instance_of HoldMethod, employee.payment_method
  end

  def test_add_salaried_employee
    emp_id = 2
    name = "Jane Smith"
    address = "456 Oak St"
    monthly_salary = 5000.0

    transaction = AddSalariedEmployee.new(emp_id, name, address, monthly_salary)
    transaction.execute

    employee = PayrollDatabase.get_employee(emp_id)
    assert_equal name, employee.name
    assert_equal address, employee.address
    assert_instance_of SalariedClassification, employee.classification
    assert_equal monthly_salary, employee.classification.monthly_salary
    assert_instance_of MonthlySchedule, employee.schedule
    assert_instance_of HoldMethod, employee.payment_method
  end

  def test_add_commissioned_employee
    emp_id = 3
    name = "Bob Johnson"
    address = "789 Elm St"
    monthly_salary = 3000.0
    commission_rate = 0.1

    transaction = AddCommissionedEmployee.new(emp_id, name, address, monthly_salary, commission_rate)
    transaction.execute

    employee = PayrollDatabase.get_employee(emp_id)
    assert_equal name, employee.name
    assert_equal address, employee.address
    assert_instance_of CommissionedClassification, employee.classification
    assert_equal monthly_salary, employee.classification.monthly_salary
    assert_equal commission_rate, employee.classification.commission_rate
    assert_instance_of BiweeklySchedule, employee.schedule
    assert_instance_of HoldMethod, employee.payment_method
  end
end
