class Job < ApplicationRecord
    belongs_to :user
    
    # user_idのエラー条件
    validates :user_id, {presence: true}
    # startのエラー条件
    validates :start, {presence: true}
    # finishのエラー条件
    validates :finish, {presence: true}
    # descriptionのエラー条件
    validates :description, {presence: true}
    # placeのエラー条件
    validates :place, {presence: true}
end
