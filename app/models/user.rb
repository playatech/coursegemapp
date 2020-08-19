class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  
  before_create :ensure_login_uniqueness
  
  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end
  
  

  # def ensure_login_uniqueness 
  #   if self.login.blank? || User.find_by_login(self.login).count > 0
  #     login_part = self.email.split("@").first
  #     new_login = login_part.dup 
  #     num = 2
  #     while(User.find_by_login(new_login).count > 0)
  #       new_login = "#{login_part}#{num}"
  #       num += 1
  #     end
  #     self.login = new_login
  #   end
  # end
  
  has_many :courses

end
