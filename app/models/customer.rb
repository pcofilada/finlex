class Customer
  include Mongoid::Document

  field :name,    type: String
  field :address, type: String
  field :email,   type: String

  validates :name, :address, presence: true
  validates :email, presence: true, uniqueness: true
end
