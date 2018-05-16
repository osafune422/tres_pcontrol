class User < ApplicationRecord
    has_many :departments
    
    # nameのエラー条件
    validates :name, {presence: true}
    # numberのエラー条件
    validates :number, {presence: true, uniqueness: true}
    # passwordのエラー条件
    validates :password, {presence: true}
end
