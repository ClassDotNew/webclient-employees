class EmployeesController < ApplicationController
  def index
    employees_hash_array = Unirest.get("http://localhost:3000/api/v1/employees").body
    @employees =[]
    employees_hash_array.each do |employee_hash|
      @employees << Employee.new(
        first_name: employee_hash['first_name'],
        last_name: employee_hash['last_name'],
        dob: employee_hash['dob'],
        ssn: employee_hash['ssn'],
        company_email: employee_hash['company_email'],
        full_name: employee_hash['full_name'],
        id: employee_hash['id']
      )
    end
    render 'index.html.erb'
  end

  def show
    @employee = Employee.find(params[:id])
    render 'show.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @employee = Unirest.post("http://localhost:3000/api/v1/employees",
                  headers:{ "Accept" => "application/json" },
                  parameters:{ :first_name => params[:form_first_name], :last_name => params[:form_last_name] }
                ).body
    redirect_to "/employees/#{@employee["id"]}"
  end

  def edit
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render 'edit.html.erb'
  end

  def update
    @employee = Unirest.patch("http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers:{ "Accept" => "application/json" },
      parameters:{ :first_name => params[:form_first_name], :last_name => params[:form_last_name] }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    Unirest.delete("http://localhost:3000/api/v1/employees/#{params['id']}")
    redirect_to "/employees"
  end
end


