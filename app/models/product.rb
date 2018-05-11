class Product < ApplicationRecord
  belongs_to :provider
  belongs_to :category
  has_many :comments
  has_many :ratings
  has_many :favourites
  has_many :order_details

  validates :name, presence: true, length: {maximum: Settings.product.name.max_length}
  validates :price, presence: true,
  numericality: {only_integer: true, greater_than_or_equal_to: Settings.product.min_price}
  scope :sort_by_name, ->{order :name}
  scope :search_by_name, ->(name){ where (" name like ?"), "%#{name}%"}
  scope :search_by_category, ->(category_id){where category_id: category_id}
  scope :search_by_price, ->(price){where(price: price) if price.presence?}
  scope :hot_product, ->(month){joins(:order_details)
    .where("order_details.created_at >= DATE_SUB(CURRENT_DATE(),INTERVAL ? MONTH)",month)
    .group("id").order("sum(order_details.quantity) DESC").limit(Settings.product.limit)
  }
  scope :lastest_product, ->(number){order(created_at: :desc).limit(number)}
end
