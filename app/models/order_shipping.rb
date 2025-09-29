class OrderShipping
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :token,
                :postal_code, :prefecture_id, :city, :address,
                :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :address
    validates :phone_number
  end

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
