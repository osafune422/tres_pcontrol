class Attend < ApplicationRecord
    belongs_to :user
    
    # user_idのエラー条件
    validates :user_id, {presence: true}
    
    
end
