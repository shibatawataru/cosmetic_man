class Tag < ApplicationRecord
  has_many :item_tags,dependent: :destroy
  # タグは複数の投稿を持つ　それはitem_tagsを通じて参照できる
  has_many :items,through: :item_tags
  validates :name, uniqueness: true, presence: true
end
