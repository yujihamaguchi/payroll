require 'minitest/autorun'
require_relative '../lib/payroll'

class AddSalariedEmployeeTransactionTest < Minitest::Test
  def setup
    Payroll::EmployeeRepository.clear
  end
  
  def test_add_salaried_employee
    # 月給制の従業員を追加するトランザクションを作成
    transaction = Payroll::AddSalariedEmployeeTransaction.new(
      emp_id: 2, 
      name: "佐藤花子", 
      address: "大阪府大阪市", 
      monthly_salary: 400000
    )
    
    # トランザクションの属性を検証
    assert_equal 2, transaction.emp_id
    assert_equal "佐藤花子", transaction.name
    assert_equal "大阪府大阪市", transaction.address
    assert_equal 400000, transaction.monthly_salary
  end
  
  def test_execute
    # 月給制の従業員を追加するトランザクションを作成して実行
    transaction = Payroll::AddSalariedEmployeeTransaction.new(
      emp_id: 2, 
      name: "佐藤花子", 
      address: "大阪府大阪市", 
      monthly_salary: 400000
    )
    transaction.execute
    
    # リポジトリから従業員を取得して検証
    employee = Payroll::EmployeeRepository.find(2)
    assert_equal 2, employee.id
    assert_equal "佐藤花子", employee.name
    assert_equal "大阪府大阪市", employee.address
    
    # 支払い分類が正しく設定されていることを検証
    assert_instance_of Payroll::SalariedClassification, employee.payment_classification
    assert_equal 400000, employee.payment_classification.monthly_salary
  end
  
  def test_invalid_monthly_salary
    # 月給が負の値の場合はArgumentErrorが発生することを検証
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        emp_id: 2, 
        name: "佐藤花子", 
        address: "大阪府大阪市", 
        monthly_salary: -1000
      )
    end
    
    # 月給が0の場合はArgumentErrorが発生することを検証
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        emp_id: 2, 
        name: "佐藤花子", 
        address: "大阪府大阪市", 
        monthly_salary: 0
      )
    end
  end
  
  def test_missing_required_parameters
    # 必須パラメータが欠けている場合はArgumentErrorが発生することを検証
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        name: "佐藤花子", 
        address: "大阪府大阪市", 
        monthly_salary: 400000
      )
    end
    
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        emp_id: 2, 
        address: "大阪府大阪市", 
        monthly_salary: 400000
      )
    end
    
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        emp_id: 2, 
        name: "佐藤花子", 
        monthly_salary: 400000
      )
    end
    
    assert_raises(ArgumentError) do
      Payroll::AddSalariedEmployeeTransaction.new(
        emp_id: 2, 
        name: "佐藤花子", 
        address: "大阪府大阪市"
      )
    end
  end
end