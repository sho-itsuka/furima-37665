class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :ship_cost
  belongs_to :ship_day
  belongs_to :ship_area
  has_one_attached :image

  validates :title, :price, :description, :image, presence: true
  validates :category_id, :item_status_id, :ship_cost_id, :ship_day_id, :ship_area_id, numericality: { other_than: 1, message: "can't be blank" }

end