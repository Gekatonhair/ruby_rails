class UserMailer < ApplicationMailer
    def welcome_email       
        @user = params[:user]
        @url  = 'http://127.0.0.1:3000/users/sign_in'
        mail(to: @user.email, subject: 'Welcome to My Awesome Site', from: 'me@mail.com')
    end

    def post_mailer(email, posts)      
        @email = email
        @posts = posts
        mail(to: email, subject: 'TEST', from: 'blog@mail.com')       
    end
end
