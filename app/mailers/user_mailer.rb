class UserMailer < ApplicationMailer
  def test_mail(user)
    @username = user.name
    @status = user.status
    mail(:to => "#{user.email}", :subject => "Test mail")
  end

  def send_birthday_wish(user)
    @username = user.name
    attachments.inline['previewImage.jpg'] = File.read('/home/mittal/Desktop/extra/images.jpg')
    attachments['image.jpg'] = File.read('/home/mittal/Desktop/extra/images.jpg')
    attachments['sample.pdf'] = File.read('/home/mittal/Desktop/extra/angularails-sample.pdf')
    mail(:to => "#{user.email}", :subject => "Wishing you happy birthday")
  end
end

