class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  NAME_REGEX  = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KANA_REGEX  = /\A[ァ-ヶー]+\z/
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i

  validates :nickname, presence: true
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }

  with_options presence: true do
    validates :last_name,       format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name,      format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :last_name_kana,  format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end
end
