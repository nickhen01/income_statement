require 'rails_helper'

RSpec.describe "/expenses", type: :request do
  let(:user) { create(:user) }
  let(:statement) { create(:statement, user: user) }

  before do
    sign_in user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_statement_expense_url(statement)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) {
        attributes_for(:expense)
      }

      it "creates a new Expense" do
        expect {
          post statement_expenses_url(statement), params: { expense: valid_attributes }
        }.to change(Expense, :count).by(1)
      end

      it "redirects to the statement" do
        post statement_expenses_url(statement), params: { expense: valid_attributes }

        expect(response).to redirect_to(statement_url(statement))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { amount: nil, name: nil }
      }

      it "does not create a new Expense" do
        expect {
          post statement_expenses_url(statement), params: { expense: invalid_attributes }
        }.to change(Expense, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post statement_expenses_url(statement), params: { expense: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
