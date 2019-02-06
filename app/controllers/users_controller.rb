class UsersController < ApplicationController   
    skip_before_action :verify_authenticity_token    
    before_action :authenticate_user!

    #def profile        
    #    @session = user_session     
    #end

    def index
        @users = User.all
    end 

    def my_posts
        @user = current_user
        @posts = Post.where(:user  => current_user)       
    end 
    
    #def show
    #    @user = current_user    
    #end 
  
    def edit_extended
        @user = current_user          
        @session = user_session       
        redirect_to edit_user_registration_path, flash: {extended: true}       
    end        

    
    def subscribe    
        user_id = params[:user_id]        
        author = User.find(user_id)

        current_user.users<<(author)
        flash[:notice] = "Вы подписались на новости #{author.email}"                                     
        redirect_to request.referrer       
    end

    def unsubscribe
        user_id = params[:user_id]        
        author = User.find(user_id)

        current_user.users.delete(author) == [author]
        flash[:notice] = "Вы отписались от новостей #{author.email}"                    
        redirect_to request.referrer       
    end

    def subscription
        print "\n\nsubscription\n\n"
        if !user_signed_in?
            flash[:notice] = "Ваша сессия устарела или недейсвительно, пожалуйста, войдите заново" 
            redirect_to new_user_session_path
        else       
            @user = current_user
            @session = user_session                    
        end              
    end

    def update
        @user = current_user               
        @session = user_session      
        
        @user.write_attribute(:subscription_type, params[:user][:subscription_type])
        if @user.update_attributes(user_params)            
            flash[:notice] =  "Параметры подписки обновлены"
            redirect_to home_path                   
        else            
            flash[:alert] =  "Неизвестная ошибка, попробуйте еще раз"
            redirect_to users_subscription_path
        end
    end

    private
    def user_params
        params.require(:user).permit(:subscription_type)
    end
end
