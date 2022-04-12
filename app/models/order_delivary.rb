class OrderDelivary
  include ActiveModel::Model
  attr_accessor :postcode, :ship_area_id, :city, :block, :building, :phonenumber, :order_id, :user_id, :item_id, :token

  validates :token, presence: true

  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows(e.g. 123-4567)' }
    validates :ship_area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city, :block, :user_id, :item_id
    validates :phonenumber, format: { with: /\A0[5789]0-?\d{4}-?\d{4}\z/, message: 'is invalid. Input only number' }
  end

  validates :phonenumber, format: { with: /\A\d{10,11}\z/, message: 'is too short' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivary.create(postcode: postcode, ship_area_id: ship_area_id, city: city, block: block, building: building,
                    phonenumber: phonenumber, order_id: order.id)
  end
end
