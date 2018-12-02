module HomesHelper

  def is_my_friend?(friend_id)
    current_user.try(:friend_ship).try(:my_friends).include?(friend_id)
  end

end
