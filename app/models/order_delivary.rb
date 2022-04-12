class OrderDelivary
  include ActiveModel::Model
  attr_accessor :postcode, :ship_area_id, :city, :block, :building, :phonenumber, :order_id, :user_id, :item_id

  with_options presence: true do
    validates :postcode, format: { with: /\A\d{3}-?\d{4}\z/, message: "is invalid. Enter it as follows(e.g. 123-4567" }
    validates :city, :block, :user_id, :item_id, :order_id
    validates :phonenumber, format: { with: /\A\d{11}\z/, message: "Phone number is invalid. Input only number" }
  end
  validates :ship_area_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Delivary.create(postcode: postcode, ship_area: ship_area, city: city, block: block, building: building, phonenumber: phonenumber, order_id: order_id)
  end
end