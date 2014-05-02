class User < ActiveRecord::Base
  has_many :transactions, :order => "created_at DESC"
end
