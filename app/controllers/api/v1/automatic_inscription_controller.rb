class Api::V1::AutomaticInscriptionController < ApplicationController

  def demo_inscription
    slug_name = params[:slug_name]
    email = params[:email]
    name =  params[:name]
    @slug = Slug.create(name: slug_name, subscription_type: '1', subscription_end: Date.today + 30 )
    @slug.save!
    if @slug.save
      password = SecureRandom.urlsafe_base64(6)
      @user_demo = User.create(slug_id: @slug.id, email: email, name: name, password: password, role: 'admin' )
      @user_demo.save!
    end

    if @user_demo.save
      UserMailer.demo_inscription(@user_demo, password).deliver
      render json: status
    end

  end
end
