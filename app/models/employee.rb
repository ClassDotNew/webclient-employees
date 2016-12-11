class Employee
  attr_accessor :first_name, :last_name, :id, :full_name, :company_email, :dob, :ssn

  def initialize(input_hash)
    @first_name = input_hash[:first_name]
    @last_name = input_hash[:last_name]
    @id = input_hash[:id]
    @full_name = input_hash[:full_name]
    @company_email = input_hash[:company_email]
    @dob = input_hash[:dob]
    @ssn = input_hash[:ssn]
  end

  def self.find(input_id)
    # go grab a hash from the api (with the input_id as id)
    employee_hash = Unirest.get("http://localhost:3000/api/v1/employees/#{input_id}").body
    # convert that hash to an object of the class employee
    employee = Employee.new(
      first_name: employee_hash['first_name'],
      last_name: employee_hash['last_name'],
      dob: employee_hash['dob'],
      ssn: employee_hash['ssn'],
      company_email: employee_hash['company_email'],
      full_name: employee_hash['full_name'],
      id: employee_hash['id']
      )
    return employee
  end

end
