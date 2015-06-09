class WishBirthdayJob < Struct.new(:user_id)
  def perform
    @user = User.find_by_id(user_id)
    UserMailer.send_birthday_wish(@user).deliver_later
  end
end
