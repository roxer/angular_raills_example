# encoding: UTF-8
class Channel < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "channels"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='channel'
  belongs_to :insurer
  has_many :products
  has_many :starpacks

  attr_accessible :insurer_id, :code, :name

  validates_presence_of :insurer_id


  HUMANIZED_ATTRIBUTES = {
      :insurer_id => 'Ubezpieczyciel',
      :code => 'Kod',
      :name => 'Nazwa'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
