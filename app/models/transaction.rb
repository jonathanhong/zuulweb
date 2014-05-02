class Transaction < ActiveRecord::Base
  belongs_to :user
	has_many :items, :foreign_key => 'transaction_id', :class_name => "TranactionItem"
end
