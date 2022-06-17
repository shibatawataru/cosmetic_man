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
end
