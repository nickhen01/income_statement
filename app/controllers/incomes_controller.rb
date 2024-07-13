class IncomesController < ApplicationController
  before_action :set_statement, only: [:new, :create]

  def new
    @income = Income.new
  end

  def create
    @income = Income.new(income_params.merge(statement: @statement))

    respond_to do |format|
      if @income.save
        format.html { redirect_to statement_url(@statement), notice: "Income was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_statement
    @statement = current_user.statements.find(params[:statement_id])
  end

  def income_params
    params.require(:income).permit(:name, :amount)
  end
end
