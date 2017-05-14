json.extract! loan, :id, :status, :keys, :due_at, :collateral, :user_id, :created_at, :updated_at
json.url loan_url(loan, format: :json)