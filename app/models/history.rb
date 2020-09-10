class History < ApplicationRecord
  belongs_to :user
  belongs_to :sale

  enum history_type: {sale: 0, purchase: 1}
end
