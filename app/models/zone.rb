# encoding: UTF-8
class Zone < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "zones"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='zone'

  has_many :product_details, :dependent => :nullify
  has_many :zone_area_limits, :dependent => :destroy #, :foreign_key => 'zone_id'
  has_many :master_areas, :through => :zone_area_limits
  has_many :limits, :through => :zone_area_limits

  attr_accessible :code, :name

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
