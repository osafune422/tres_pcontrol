class Actualwork < ApplicationRecord
    belongs_to :user
    
    # user_idのエラー条件
    validates :user_id, {presence: true}
    # yearのエラー条件
    validates :year, {presence: true}
    # monthのエラー条件
    validates :month, {presence: true}
    # ordistartのエラー条件
    validates :ordistart, {presence: true}
    # ordifinishのエラー条件
    validates :ordifinish, {presence: true}
end
