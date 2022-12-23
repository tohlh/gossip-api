class Comment < ApplicationRecord
  has_one :user, required: true
  has_one :post, required: true
end
