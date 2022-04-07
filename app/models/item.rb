class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :item_status
  belongs_to :ship_cost
  belongs_to :ship_day
  belongs_to :ship_area
  has_one_attached :image
  
  validates :title, :description, :image, presence: true
  validates :category_id, :item_status_id, :ship_cost_id, :ship_day_id, :ship_area_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options presence: true, format: { with: /\A[0-9]+\z/, message: "is invalid.Input half-width characters" }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" } do
    validates :price
  end

end