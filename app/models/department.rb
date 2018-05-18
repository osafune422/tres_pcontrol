class Department < ApplicationRecord
    belongs_to :user
    
    # user_idのエラー条件
    validates :user_id, {presence: true}
    # departmentのエラー条件
    validates :department, {presence: true}
end
