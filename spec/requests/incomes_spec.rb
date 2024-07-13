require 'rails_helper'

RSpec.describe "/incomes", type: :request do
  let(:user) { create(:user) }
  let(:statement) { create(:statement, user: user) }

  before do
    sign_in user
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_statement_income_url(statement)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) {
        attributes_for(:income)
      }

      it "creates a new Income" do
        expect {
          post statement_incomes_url(statement), params: { income: valid_attributes }
        }.to change(Income, :count).by(1)
      end

      it "redirects to the statement" do
        post statement_incomes_url(statement), params: { income: valid_attributes }

        expect(response).to redirect_to(statement_url(statement))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { amount: nil, name: nil }
      }

      it "does not create a new Income" do
        expect {
          post statement_incomes_url(statement), params: { income: invalid_attributes }
        }.to change(Income, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post statement_incomes_url(statement), params: { income: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
