class User < ApplicationRecord
  has_many :evaluations, dependent: :destroy
  has_many :presentations, through: :evaluation
  has_many :judges, through: :evaluation

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  def email_required?
    false
  end

  def is_admin?
    return has_keyword?('admin')
  end

  def is_member?
    return has_keyword?('member')
  end

  private
  def has_keyword?(key)
    return role.split(',').map{|x| x.strip}.include?(key)
  end
end
