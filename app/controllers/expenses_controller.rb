class ExpensesController < ApplicationController
  before_action :set_statement, only: [:new, :create]

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params.merge(statement: @statement))

    respond_to do |format|
      if @expense.save
        format.html { redirect_to statement_url(@statement), notice: "Expense was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_statement
    @statement = current_user.statements.find(params[:statement_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
