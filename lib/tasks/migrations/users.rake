# bundle exec rake users:create_random_user
namespace :users do 
  desc "creating users"
  task :create_random_user, [:times] => :environment do |t, args|
    time = args[:times].present? ? args[:times].to_i : 10
      time.to_i.times do 
        user_name = Faker::FunnyName.name.split(" ").join("_").downcase  
        email_address = Faker::Internet.email
        password = Faker::Internet.email
        User.create!(username: user_name, email: email_address, password: user_name)
      end
      create_friendship

  end



  #to randomly assign any number of friends to a user
  def create_friendship
    users = User.all
    ids = users.pluck(:id).map{|id| id.to_s}
    users.each do |user|
      friend_count = [*1..5].sample
      user_id = user.id.to_s
      my_friends_ids = users.where(:id.nin => [user_id]).take(friend_count).pluck(:id)
      FriendShip.create!(user_id: user.id, my_friends: my_friends_ids)
    end
  end


end