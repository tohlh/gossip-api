class Tag < ApplicationRecord
  validates :title,
            format: { with: /\A(?=.{2,28}\z)([_a-z0-9]*)\z/,
                      message: "only allows 2-28 characters of alphabets, numbers and underscores" }
end
