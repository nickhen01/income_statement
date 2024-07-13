# == Schema Information
#
# Table name: statements
#
#  id         :bigint           not null, primary key
#  date       :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_statements_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Statement, type: :model do
  describe "#total_income" do
    it 'returns the sum of incomes' do
      statement = create(:statement)
      create(:income, amount: 1000, statement: statement)
      create(:income, amount: 300, statement: statement)

      total_income = statement.total_income

      expect(total_income).to eq 1300.0
    end
  end

  describe "#total_expense" do
    it 'returns the sum of expenses' do
      statement = create(:statement)
      create(:expense, amount: 500, statement: statement)
      create(:expense, amount: 300, statement: statement)

      total_expense = statement.total_expense

      expect(total_expense).to eq 800.0
    end
  end

  describe "#disposable_income" do
    it 'returns the disposable income' do
      statement = create(:statement)
      create(:income, amount: 1000, statement: statement)
      create(:expense, amount: 300, statement: statement)

      disposable_income = statement.disposable_income

      expect(disposable_income).to eq 700.0
    end
  end

  describe "#expense_ratio" do
    it 'returns the expense ratio' do
      statement = create(:statement)
      create(:income, amount: 1000, statement: statement)
      create(:expense, amount: 300, statement: statement)

      expense_ratio = statement.expense_ratio

      expect(expense_ratio).to eq 0.3
    end
  end

  describe "#rating" do
    context 'when ratio below 10%' do
      it 'returns A' do
        statement = create(:statement)
        create(:income, amount: 1000, statement: statement)
        create(:expense, amount: 50, statement: statement)

        rating = statement.rating

        expect(rating).to eq 'A'
      end
    end

    context 'when ratio between 10% and 30%' do
      it 'returns B' do
        statement = create(:statement)
        create(:income, amount: 1000, statement: statement)
        create(:expense, amount: 250, statement: statement)

        rating = statement.rating

        expect(rating).to eq 'B'
      end
    end

    context 'when ratio between 30% and 50%' do
      it 'returns C' do
        statement = create(:statement)
        create(:income, amount: 1000, statement: statement)
        create(:expense, amount: 400, statement: statement)

        rating = statement.rating

        expect(rating).to eq 'C'
      end
    end

    context 'when ratio is above 50%' do
      it 'returns D' do
        statement = create(:statement)
        create(:income, amount: 1000, statement: statement)
        create(:expense, amount: 700, statement: statement)

        rating = statement.rating

        expect(rating).to eq 'D'
      end
    end
  end
end
