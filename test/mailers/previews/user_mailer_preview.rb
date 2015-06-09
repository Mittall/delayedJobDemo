# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def test_mail
    UserMailer.test_mail(User.first)
  end
  
  def send_birthday_wish
    UserMailer.send_birthday_wish(User.first)
  end
end
