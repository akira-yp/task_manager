class User < ApplicationRecord
  validates :name, presence:true, length: { maximum:30 }
  validates :email, presence:true, length: { maximum:255 }, format:{ with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness:true
  validates :password_digest, presence: true, length:{ minimum: 6 }
  before_validation {email.downcase!}

  before_destroy :not_destroy_or_update_last_admin

  has_secure_password

  has_many :tasks

  private
    def not_destroy_or_update_last_admin
      if User.where(admin: true).count == 1 && self.admin?
        throw :abort
      end
    end
end
