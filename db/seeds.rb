# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


companyA = Company.create!(name: 'Empresa AAA', legal_name:'Empresa AAA LTDA', cnpj: '98922455000169',
                          address:'Rua A, 100', social_media:'linkedin', domain:'@empresaaaa.com.br')
companyB = Company.create!(name: 'Empresa BBB', legal_name:'Empresa BBB LTDA', cnpj: '63325234000129',
                           address:'Rua B, 200', social_media:'linkedin', domain:'@empresabbb.com.br')

employee1 = CompanyEmployee.create!(full_name:'Marco Silva Lima',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'48227940080',company: companyA)
employee2 = CompanyEmployee.create!(full_name:'Marlene Delgado Souza',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'06683034095',company: companyA)
employee3 = CompanyEmployee.create!(full_name:'Maria Adonai Silva',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'65756294074',company: companyA)
employee4 = CompanyEmployee.create!(full_name:'Jessica Alado Ferr',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'17433136088',company: companyA)
employee5 = CompanyEmployee.create!(full_name:'Marcio Olivetto Rodrigues',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'17403755057',company:companyB)
employee6 = CompanyEmployee.create!(full_name:'Sonia Lima Stark',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'97708583071',company:companyB)
employee7 = CompanyEmployee.create!(full_name:'Dayane Targaryen de Souza',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'50347897010',company:companyB)
employee8 = CompanyEmployee.create!(full_name:'João das Neves',date_of_birth:'19/05/1990',position:'Recrutador',
                        departament:'RH',cpf:'75443287087',company:companyB)

user1 = User.create!(name: 'Marco Lima', email:'admin@empresaaaa.com.br',password: '12345678', company_employee:employee1)
user2 = User.create!(name: 'Marlene Souza', email:'marlene@empresaaaa.com.br',password: '12345678', company_employee:employee2)
user3 = User.create!(name: 'Maria Silva', email:'maria@empresaaaa.com.br',password: '12345678', company_employee:employee3)
user4 = User.create!(name: 'Jessica Ferr', email:'jessica@empresaaaa.com.br',password: '12345678', company_employee:employee4)
user5 = User.create!(name: 'Marcio Rodrigues', email:'marcio@empresabbb.com.br',password: '12345678', company_employee:employee5)
user6 = User.create!(name: 'Sonia Stark', email:'sonia@empresabbb.com.br',password: '12345678', company_employee:employee6)
user7 = User.create!(name: 'Dayane Targaryen', email:'dayane@empresabbb.com.br',password: '12345678', company_employee:employee7)
user8 = User.create!(name: 'João das Neves ', email:'joao@empresabbb.com.br',password: '12345678', company_employee:employee8)

category1 = ProductCategory.create!(name:'Eletrônicos', description:'Categoria para eletrônicos') 
category2 = ProductCategory.create!(name:'Móveis', description:'Categoria para Móveis') 



ad1 = Ad.create!(title:'Produto A', description:'Descrição do produto A',price:10,
           status:0 ,product_category:category1,company_employee: employee1)
ad2 = Ad.create!(title:'Produto B', description:'Descrição do produto B',price:20,
           status:0, product_category:category2,company_employee: employee1)
ad3 = Ad.create!(title:'Produto C', description:'Descrição do produto C',price:30,
           status:0 ,product_category:category1,company_employee: employee2)
ad4 = Ad.create!(title:'Produto D', description:'Descrição do produto D',price:10,
           status:0 ,product_category:category2,company_employee: employee3)
ad5 = Ad.create!(title:'Produto E', description:'Descrição do produto E',price:20,
           status:0, product_category:category1,company_employee: employee4)
ad6 = Ad.create!(title:'Produto F', description:'Descrição do produto F',price:30,
           status:0 ,product_category:category2,company_employee: employee5)
ad7 = Ad.create!(title:'Produto G', description:'Descrição do produto G',price:10,
          status:0 ,product_category:category1,company_employee: employee6)
ad8 = Ad.create!(title:'Produto H', description:'Descrição do produto H',price:20,
          status:0, product_category:category2,company_employee: employee7)
ad9 = Ad.create!(title:'Produto I', description:'Descrição do produto I',price:30,
          status:0 ,product_category:category1,company_employee: employee8)

sale1 = Sale.create!(buyer: user1, ad:ad3 , status:'in_progress',final_price: nil)
sale2 = Sale.create!(buyer: user2, ad:ad1, status:'finished',final_price: 200)

History.create!(user:user1,sale:sale1, history_type:'purchase')
History.create!(user:user1,sale:sale2, history_type:'sale')



                