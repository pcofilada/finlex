class ContractsController < ApplicationController
  before_action :set_customer
  before_action :set_contract, only: %i[show update destroy]

  def index
    @contracts = @customer.contracts

    render json: @contracts
  end

  def show
    render json: @contract
  end

  def create
    @contract = @customer.contracts.new(contract_params)

    if @contract.save
      render json: @contract, status: :created
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  def update
    if @contract.update(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @contract.destroy
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_contract
    @contract   = @customer.contracts.find(params[:id])
  end

  def contract_params
    params.require(:contract).permit(:price, :start_date, :end_date, :expiry_date)
  end
end
