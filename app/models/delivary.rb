class Delivary < ApplicationRecord
  belongs_to :order
  belongs_to :ship_area

end
