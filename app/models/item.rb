class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :prefecture
  belongs_to :shipping_day
  belongs_to :shipping_fee

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :shipping_day_id
    validates :prefecture_id
    validates :price
  end

  # '---' (id:1) を弾く
  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :shipping_day_id
    validates :prefecture_id
  end

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }
end
