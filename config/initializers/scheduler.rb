# config/initializers/scheduler.rb
require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

#<секунды> <минуты> <часы> <дни> <месяцы> <дни недели>

#every day at 7:00
scheduler.cron '00 00 07 */1 * *' do
    users = User.where(:subscription_type => 'day').all      
    day_posts = Post.where("created_at >= ?", Date.today.prev_day.at_beginning_of_day)         
    users.each do |user|
        posts = day_posts.where(:user => user.subscription)
        UserMailer.post_mailer(user.email, posts).deliver_now           
    end
end


#every week, at monday, at 7:00 
scheduler.cron '00 00 07 * * 1' do
    users = User.where(:subscription_type => 'week').all      
    week_posts = Post.where("created_at >= ?", Date.today.prev_day.at_beginning_of_week)        
    users.each do |user|
        posts = week_posts.where(:user => user.subscription)
        UserMailer.post_mailer(user.email, posts).deliver_now           
    end
end


#for test set '30s' (запустится через 30 секунд  после старта сервера)
scheduler.in '2s' do 
    print "\nMAILER\n"
    users = User.where(:subscription_type => 'week').all      
    week_posts = Post.where("created_at >= ?", Date.today.prev_day.at_beginning_of_week)        
    users.each do |user|                      
        #выбираем посты из подписок
        posts = week_posts.where(:user => user.subscription)
        #UserMailer.post_mailer(user.email, subscribe_posts).deliver_now           
    end
end
