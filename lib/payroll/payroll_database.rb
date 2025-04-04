class PayrollDatabase
  @@employees = {}

  def self.add_employee(employee)
    @@employees[employee.emp_id] = employee
  end

  def self.get_employee(emp_id)
    @@employees[emp_id]
  end
end
