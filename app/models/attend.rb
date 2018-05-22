class Attend < ApplicationRecord
    belongs_to :user
    
    # user_idのエラー条件
    validates :user_id, {presence: true}
    # dateのエラー条件
    validates :date, {presence: true}
    
    
end
