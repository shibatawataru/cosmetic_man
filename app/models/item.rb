class Item < ApplicationRecord
  belongs_to :customer
  has_many :item_tags,dependent: :destroy
  has_many :tags,through: :item_tags
  has_many :comments, dependent: :destroy
  has_one_attached :product_image
  
  validates :itemname, :body, :price, :evaluation, presence: true
  validates :price, numericality: true

  def get_product_image(width, height)
    unless product_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      product_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    product_image.variant(resize_to_limit: [width, height]).processed
  end

  def save_tag(sent_tags)
    # タグのIDをすべて配列で取得しcurrent_tagsとする
    current_tags = self.tags.pluck(:id) unless self.tags.nil?

    # 現在取得したタグから送られてきたタグを除いてold_tagsとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnew_tagsとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す(self = 自分自身のsave/updateされた時の情報)
    old_tags.each do |old|
      ItemTag.find_by(item_id: self.id, tag_id: old).destroy
    end

    # 新しいタグを保存(self = 自分自身のsave/updateされた時の情報)
    new_tags.each do |new|
      ItemTag.find_or_create_by(item_id: self.id, tag_id: new)
    end
  end
end
