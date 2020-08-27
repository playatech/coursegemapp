class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  
  rolify
  
  # before_create :ensure_login_uniqueness
  
  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end
  
  has_many :courses
  
  
  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:teacher)
      self.add_role(:student)
    else
      self.add_role(:student) if self.roles.blank?
      self.add_role(:teacher) #if you want any user to be able to create own courses
    end
  end

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