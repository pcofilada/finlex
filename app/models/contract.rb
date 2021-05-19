class Contract
  include Mongoid::Document

  field :price,       type: BigDecimal
  field :start_date,  type: Date
  field :end_date,    type: Date
  field :expiry_date, type: Date

  belongs_to :customer

  validates :price, :start_date, :end_date, :expiry_date, presence: true
end
