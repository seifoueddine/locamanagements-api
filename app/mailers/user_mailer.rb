class UserMailer < ApplicationMailer


  def demo_inscription(user,password)
    @password = password
    @user = user
    mail to: @user.email, subject: 'Votre demo pour LOCA-managments'
  end

end
