class CustomersController < ApplicationController

  before_action :set_customer, only: [:show, :update , :edit, :destroy]

  before_action :set_company, only: [:new, :edit]

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @customers = Customer.page(params[:page])
  end

  def new
    #@companies = Company.all
    @customer = Customer.new #なぜ大文字にする？modelだから？
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      #trueの時
      redirect_to @customer #なぜこれでshowに行ける？
    else render :new
      #falseの時render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    #@customer = Customer.find(params[:id])
  end

  def destroy
    @customer.destroy
    redirect_to customers_url
  end

  private
  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email,
      :company_id
      )
  end

  #befrore_acton置き場
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_company
    @customer = Customer.new
  end
end
