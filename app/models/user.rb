class User < ActiveRecord::Base

  validates :first_name, :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 8 }
  validates :auth_token, uniqueness: true

  before_save :downcase_email
  before_create :set_auth_token

  def set_auth_token
    self.auth_token = generate_auth_token
  end


  def delete_auth_token
    self.auth_token = nil
    save
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    def generate_auth_token
      loop do
        token = SecureRandom.hex
        break token unless self.class.exists?(auth_token: token)
      end
    end
end
