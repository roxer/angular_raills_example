# encoding: UTF-8
class Area < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "areas"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='areas'

  has_many :area_containers, :foreign_key => 'areas_id'
  has_many :master_areas, :through => :area_containers

  attr_accessible :code, :name

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
