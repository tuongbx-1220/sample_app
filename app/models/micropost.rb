class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :newest, ->{order(created_at: :desc)}
  validates :content, presence: true,
            length: {maximum: Settings.length_digit_140}
  validates :image,
            content_type: {in: %w(image/jpeg image/gif image/png),
                          message: I18n.t("invalid_format")},
            size: {less_than: Settings.size_5.megabytes,
                  message: I18n.t("large_size")}

  def display_image
    image.variant resize_to_limit: Settings.size_500_image
  end
end
