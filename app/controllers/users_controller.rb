class UsersController < ApplicationController   
    skip_before_action :verify_authenticity_token

    def profile
        @user = current_user
        @session = user_session     
    end

    def index
        @users = User.all
    end 
    
    def postmailer
        users = User.all
        print "\n"
        #print users.inspect      
        print "\n"
        Rails.logger.info "hello, it #{Time.now}"
    end

    #def show
    #    @user = current_user    
    #end 
    

    def subscription
        if !user_signed_in?
            flash[:notice] = "Ваша сессия устарела или недейсвительно, пожалуйста, войдите заново" 
            redirect_to '/users/sign_in' 
        else       
            @user = current_user
            @session = user_session          
        end              
    end

    def update
        @user = current_user               
        @session = user_session

        @user.write_attribute(:subscription, params[:user][:subscription])
        if @user.update_attributes(user_params)
            print "ALL GOOD\n"#       
            flash[:notice] =  "Параметры подписки обновлены"
            redirect_to home_path                   
        else
            print "ERROR\n"#
            flash[:alert] =  "Неизвестная ошибка, попробуйте еще раз"
            redirect_to users_subscription_path
        end
    end

    private
    def user_params
        params.require(:user).permit(:subscription)
    end
end
