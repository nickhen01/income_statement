class StatementsController < ApplicationController
  def index
    @statements = current_user.statements.order(date: :desc)
  end

  def show
    @statement = current_user.statements.find(params[:id])
  end

  def new
    @statement = Statement.new
  end

  def create
    @statement = Statement.new(statement_params.merge(user: current_user))

    respond_to do |format|
      if @statement.save
        format.html { redirect_to statement_url(@statement), notice: "Statement was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def statement_params
    params.require(:statement).permit(:date)
  end
end
