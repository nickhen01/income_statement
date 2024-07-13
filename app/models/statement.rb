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
class Statement < ApplicationRecord
  belongs_to :user
  has_many :incomes
  has_many :expenses

  validates :date, presence: true

  def total_income
    incomes.sum(:amount) || 0.0
  end

  def total_expense
    expenses.sum(:amount) || 0.0
  end

  def disposable_income
    total_income - total_expense
  end

  def expense_ratio
    total_expense / total_income
  end

  def rating
    case expense_ratio
    when 0...0.1 then 'A'
    when 0.1...0.3 then 'B'
    when 0.3...0.5 then 'C'
    when 0.5.. then 'D'
    else 'n/a'
    end
  end
end
