class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, comparison: {greater_than: 0}
    validates :stock, comparison: {greater_than_or_equal_to: 0}
    has_one_attached :image # method found at https://tinyurl.com/4mpvx49d
end
