class UserMailer < ActionMailer::Base
  default from: "kareem@getuserwise.com"

  def order_confirmation_email(user)
    @user = user
    mail(:to => user.email, :subject => "Order Confirmation")
  end
end
