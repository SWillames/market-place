class CompanyEmployeesController < ApplicationController
    before_action :authenticate_user!, only: [:show, :new, :create]

    def show
       @company_employee  = CompanyEmployee.find(params[:id])
     end

    def new
        @company_employee = CompanyEmployee.new
    end

    def create
        @user = User.find(current_user.id)
        @company_employee = @user.build_company_employee(company_employee_params) 
        @company_employee.save
        redirect_to @company_employee, notice: 'Perfil salvo com sucesso!'
    end

    private 

    def company_employee_params
        company = Company.find_by(domain: current_user.domain)
        params.require(:company_employee)
              .permit(:full_name,:date_of_birth,:position,:departament,:cpf)
              .merge(company: company)
    end
end