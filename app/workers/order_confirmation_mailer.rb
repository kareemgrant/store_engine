class OrderConfirmationMailer
  @queue = :order_confirmation_queue

  def self.perform(user_id)
    user = User.find(user_id)
    UserMailer.order_confirmation_email(user).deliver
  end
end
