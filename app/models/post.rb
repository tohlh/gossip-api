class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tag_assignments, dependent: :destroy
  has_many :tags, through: :tag_assignments
  validates :title, presence: true, length: { minimum: 8 }
end
