class SharedLocation
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps


  field :user_id, type: BSON::ObjectId
  field :location, type: Array, default: []
  field :shared_with_ids, type: Array, default: []

  field :shared_public, type: Boolean
  belongs_to :user, index:{background: true}
end

# do below in mongoid
# db.shared_locations.createIndex({user_id: 1})