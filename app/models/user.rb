class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  enum role: [:user, :admin]

  validates	:first_name,  presence: true
  validates	:last_name,   presence: true

  before_save	:admin_role_for_first_created_user!, if: lambda { User.count < 1 }
  before_save	:format_first_name_attribute!, :format_last_name_attribute!

  after_initialize do
    @created_by_admin = false
  end

  def name
    "#{first_name} #{last_name}"
  end

  def created_by_admin!
    @created_by_admin = true
  end

  def password_required?
    return false if @created_by_admin
    super
  end

  protected

    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end

  private

    def admin_role_for_first_created_user!
      self.role = :admin
    end

    def format_first_name_attribute!
      self.first_name.capitalize!
    end

    def format_last_name_attribute!
      self.last_name.upcase!
    end
end
