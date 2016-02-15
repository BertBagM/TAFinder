class User < ActiveRecord::Base
  validates :email,
    presence: true,
    uniqueness: true,
    length: { in: 3..50 },
    format: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :password
    presence: true,
    confirmation: true,
    length: { in: 6..50 },
    on: :create
end
