# encoding: UTF-8
class MasterArea < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "master_areas"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='area'

  has_many :area_containers, :dependent => :destroy #, :foreign_key => 'area_id'
  has_many :areas, :through => :area_containers
  has_many :zone_area_limits, :dependent => :destroy #, :foreign_key => 'area_id'
  has_many :limits, :through => :zone_area_limits, :dependent => :destroy
  has_many :zones, :through => :zone_area_limits

  attr_accessible :code, :name

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa'
  }

end
