# == Schema Information
#
# Table name: cash_flows
#
#  id           :bigint           not null, primary key
#  amount       :float
#  name         :string
#  type         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  statement_id :bigint           not null
#
# Indexes
#
#  index_cash_flows_on_statement_id  (statement_id)
#
# Foreign Keys
#
#  fk_rails_...  (statement_id => statements.id)
#
class Income < CashFlow
end
