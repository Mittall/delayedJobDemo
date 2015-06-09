class SendMailJob < Struct.new(:user_id)
  def perform
    @user = User.find_by_id(user_id)
    if @user.status == "current"
      UserMailer.test_mail(@user).deliver_later
      #Delayed::Job.enqueue(SendMailJob.new(user_id), :queue => 'tracking')
    else
      delayed_day = (@user.date_to_receive - Date.today).to_i
      Delayed::Job.enqueue(SendMailJob.new(user_id), :priority => delayed_day, :run_at => delayed_day.days.from_now, :queue => 'later')
    end
  end
end

