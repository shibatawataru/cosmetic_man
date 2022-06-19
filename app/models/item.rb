class Item < ApplicationRecord
    belongs_to :customer
    has_many :item_tags,dependent: :destroy
    has_many :tags,through: :item_tags
    has_many :comments, dependent: :destroy
    has_one_attached :product_image
    
    def get_product_image(width, height)
      unless product_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpeg')
        product_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      product_image.variant(resize_to_limit: [width, height]).processed
    end
    
  def save_tag(sent_tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete　Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_item_tag = Tag.find_or_create_by(name: new)
      self.tags << new_item_tag
    end
  end
end
