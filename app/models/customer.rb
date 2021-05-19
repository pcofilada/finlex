class Customer
  include Mongoid::Document

  field :name,    type: String
  field :address, type: String
  field :email,   type: String

  has_many :contracts

  validates :name, :address, presence: true
  validates :email, presence: true, uniqueness: true
end
