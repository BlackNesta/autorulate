class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "[Autorulate] Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "[Autorulate] Password reset"
  end
end
