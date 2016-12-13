class Employee
  attr_accessor :first_name, :last_name, :id, :full_name, :company_email, :dob, :ssn

  def initialize(input_hash)
    @id = input_hash[:id]
    @first_name = input_hash[:first_name]
    @last_name = input_hash[:last_name]
    @full_name = input_hash[:full_name]
    @company_email = input_hash[:company_email]
    @dob = input_hash[:dob]
    @ssn = input_hash[:ssn]
  end

  def self.find(input_id)
    employee_hash = Unirest.get("http://localhost:3000/api/v1/employees/#{input_id}", headers:{ "Accept" => "application/json", "Authorization" => 'Token token=imsocool', 'X-User-Email' => 'fakeemail' }).body

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

  def self.all
    # get all the employees from my api
    employees_hash_array = Unirest.get("http://localhost:3000/api/v1/employees").body
    # convert them to objects
    employees =[]
    employees_hash_array.each do |employee_hash|
      employees << Employee.new(
        first_name: employee_hash['first_name'],
        last_name: employee_hash['last_name'],
        dob: employee_hash['dob'],
        ssn: employee_hash['ssn'],
        company_email: employee_hash['company_email'],
        full_name: employee_hash['full_name'],
        id: employee_hash['id']
      )
    end
    # return the array
    return employees
  end

  def self.create(input_hash)
    employee_hash = Unirest.post("http://localhost:3000/api/v1/employees",
                  headers:{ "Accept" => "application/json", "Authorization" => 'Token token=imsocool', 'X-User-Email' => 'fakeemail' },
                  parameters:{ :first_name => input_hash[:first_name], :last_name => input_hash[:last_name] }
                ).body
    return Employee.new(id: employee_hash['id'],
          first_name: employee_hash['first_name'],
          last_name: employee_hash['last_name'])
  end

  def update(input_hash)
    employee = Unirest.patch("http://localhost:3000/api/v1/employees/#{id}",
      headers:{ "Accept" => "application/json" },
      parameters:{ :first_name => input_hash[:first_name], :last_name => input_hash[:last_name] }
    ).body
  end

  def destroy
    Unirest.delete("http://localhost:3000/api/v1/employees/#{id}")
  end

end
