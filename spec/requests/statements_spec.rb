require 'rails_helper'

RSpec.describe "/statements", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "renders a successful response" do
      create(:statement, user: user)

      get statements_url

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      statement = create(:statement, user: user)

      get statement_url(statement)

      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_statement_url

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_attributes) {
        attributes_for(:statement)
      }

      it "creates a new Statement" do
        expect {
          post statements_url, params: { statement: valid_attributes }
        }.to change(Statement, :count).by(1)
      end

      it "redirects to the created statement" do
        post statements_url, params: { statement: valid_attributes }
        expect(response).to redirect_to(statement_url(Statement.last))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) {
        { date: nil }
      }

      it "does not create a new Statement" do
        expect {
          post statements_url, params: { statement: invalid_attributes }
        }.to change(Statement, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post statements_url, params: { statement: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end
end
