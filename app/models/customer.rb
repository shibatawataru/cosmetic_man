class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :items, dependent: :destroy
  validates :name, uniqueness: true, length: { in: 1..20 }
  has_many :comments, dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
       profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: "guest") do |customer|
      customer.password = SecureRandom.urlsafe_base64
  end
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
end