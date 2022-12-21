class Post < ApplicationRecord
  belongs_to :user
  has_many :tag_assignments, dependent: :destroy
  has_many :tags, through: :tag_assignments
  validates :title, presence: true
end
