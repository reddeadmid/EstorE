class Product < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :price, comparison: {greater_than: 0}
    validates :stock, comparison: {greater_than_or_equal_to: 0}
end
