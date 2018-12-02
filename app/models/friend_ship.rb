class FriendShip
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps


  field :user_id, type: String
  field :my_friends, type: Array, default: []

  belongs_to :user, index:{background: true}
 
end

# in mongodb do the followng to create index
# db.friend_ships.createIndex({user_id: 1})