class TagAssignment < ApplicationRecord
  belongs_to :post, required: true
  belongs_to :tag, required: true
end
