class CompanyEmployeesController < ApplicationController

    def show
        @company_employee = CompanyEmployee.find(params[:id])
    end

    def new
        company_id = Company.find_by(domain: '@empresa01.com')
        @company_employee = CompanyEmployee.new(company_id: company_id)
    end

    def create
        @company_employee = CompanyEmployee.new(company_employee_params)
        @company_employee.company_id = 1
        if @company_employee.save
            redirect_to @company_employee , notice: 'Perfil salvo com sucesso!'
        else
            render :new
        end
    end

    private
    
    def company_employee_params
        params.require(:company_employee)
              .permit(:full_name, :name, :birth_date, :position, :departament,:cpf)
              
    end
end