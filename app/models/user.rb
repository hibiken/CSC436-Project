class User < ActiveRecord::Base

  before_save :downcase_email

  validates :first_name, :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }

  private

    def downcase_email
      self.email = email.downcase
    end
end
