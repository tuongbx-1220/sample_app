class User < ApplicationRecord
  before_save :downcase_email
  validates :name, presence: true,
    length: {maximum: Settings.length_digit_255}
  validates :email, presence: true,
    length: {maximum: Settings.length_digit_255},
    format: {with: Settings.email_regex},
    uniqueness: true
  validates :password, presence: true,
    length: {maximum: Settings.length_digit_6}

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
