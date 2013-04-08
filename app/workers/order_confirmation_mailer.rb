class OrderConfirmationMailer
  @queue = :order_confirmation_queue

  binding.pry

  def self.perform(user_id)
    binding.pry
    user = User.find(user_id)
    UserMailer.order_confirmation_email(user).deliver
  end
end
