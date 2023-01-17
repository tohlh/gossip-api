class User < ApplicationRecord
  attr_accessor :skip_validations
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :username,
            presence: true,
            uniqueness: true,
            length: { minimum: 5 },
            format: { without: /\s/, message: "only allows no space" }
  validates :password,
            presence: true,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? },
            unless: :skip_validations
  validates :password_confirmation,
            presence: true,
            unless: :skip_validations
end
