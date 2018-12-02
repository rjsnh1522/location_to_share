class HomesController < ApplicationController
  before_action :authenticate_user!, except: :my_public_share

  def index 
    my_friend_ids = FriendShip.find_by(user_id: current_user.id).my_friends
    @my_friends   = User.where(:id.in => my_friend_ids)
    @shared_locations = current_user.shared_locations
  end

  def find_friends
    @find_friends = User.where(:id.nin => [current_user.id])
  end

  def share_with_friends
    locations    = params[:locations].present? ? params[:locations] : []
    friends      = params[:friend_id].present? ? params[:friend_id] : []
    public_share = params[:public].present? && params[:public] == 'true' ? true : false
    if locations.present? && friends.present?
      locations.each do |loc|
        shared_location = current_user.shared_locations.build
        shared_location.location = loc.split(',').map(&:to_f)
        shared_location.shared_with_ids = friends
        shared_location.shared_public = public_share
        shared_location.save!
      end
    end
  end

  def remove_my_friend
    friend_id = params[:friend_id]
    if friend_id.present?
      my_friend_ship = current_user.try(:friend_ship)
      my_friends = my_friend_ship.try(:my_friends)
      left_friends = my_friends.select{|id| id != BSON::ObjectId(friend_id)}
      my_friend_ship.update_attributes(my_friends: left_friends) if left_friends
    end
    redirect_to find_friends_path
  end

  def add_my_friend
    friend_id = params[:friend_id]
    if friend_id.present?
      my_friend_ship = current_user.try(:friend_ship)
      my_friends = my_friend_ship.try(:my_friends)
      left_friends = my_friends.push(BSON::ObjectId(friend_id)).uniq
      my_friend_ship.update_attributes(my_friends: left_friends) if left_friends
    end
    redirect_to find_friends_path
  end

  def my_public_share
    @msg = "No user found"
    if params[:username].present?
      user = User.where(username: params[:username]).last
      if user.present?
        @public_locations = SharedLocation.where(user_id: user.id, shared_public: true)
        @msg = "No public location shared by this user"
        if @public_locations.present?
          @msg = ""
        end
      end
    end
  end


end
