class Tag < ApplicationRecord
  has_many :tag_assignments, dependent: :destroy
  has_many :posts, through: :tag_assignments
  validates :title,
            uniqueness: true,
            format: { with: /\A(?=.{2,20}\z)([_a-z0-9]*)\z/,
                      message: "only allows 2-20 characters of alphabets, numbers and underscores" }
end
