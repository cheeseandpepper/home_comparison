class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :assign_color
  has_many :houses

  VALID_ROLES = ['buyer', 'collaborator']

  def assign_color
    self.color = COLOR_LIST.sample
  end
end
