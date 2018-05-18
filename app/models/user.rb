class User < ApplicationRecord
    has_secure_password
    has_many :departments
    has_many :jobs
    
    # nameのエラー条件
    validates :name, {presence: true}
    # numberのエラー条件
    validates :number, {presence: true, uniqueness: true}
    # passwordのエラー条件
    validates :password, {presence: true}
end
