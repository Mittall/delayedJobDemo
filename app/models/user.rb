require 'send_mail_job'
require 'wish_birthday_job'
class User < ActiveRecord::Base
  validates_presence_of :name
  validates :email, :presence => true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  
  def validate_email
    
  end
  
  def user_send
    SendMailJob.new(self.id).perform
  end
 
  def send_wish(uId)
    WishBirthdayJob.new(uId).perform
  end

  before_save :set_status
  
  private

  def set_status
    if self.date_to_receive == Date.today
      current?
    else
      later?  
    end
  end

  def current?
    self.status = "current"
  end

  def later?
    self.status = "later"
  end

end
