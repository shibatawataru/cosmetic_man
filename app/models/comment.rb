class Comment < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  validates :comment_content, presence: true
end
