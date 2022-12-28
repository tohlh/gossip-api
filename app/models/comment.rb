class Comment < ApplicationRecord
  belongs_to :user, required: true
  belongs_to :post, required: true
  validates :content, presence: true, length: { minimum: 1 }
end
