class Comment < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :post, required: true
end
