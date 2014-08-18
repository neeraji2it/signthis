class User < ActiveRecord::Base
  include Clearance::User

  has_many :documents, foreign_key: :architect_id
end
