# encoding: UTF-8
class ZoneAreaLimit < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "zone_area_limits"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  # self.table_name='pkb_area_limits'

  belongs_to :zone #, :foreign_key => 'zone_id'
  belongs_to :master_area #, :foreign_key => 'area_id'
  belongs_to :limit, :dependent => :destroy #, :foreign_key => 'limits_id'

  validates_presence_of :zone_id

  attr_accessible :zone_id, :area_id, :limits_id

  HUMANIZED_ATTRIBUTES = {
      :zone_id => 'Strefa',
      :area_id => 'Obszar',
      :limits_id => 'Limit'
  }

  def self.limits_for_master_area_and_zone(master_area, zone)
    ZoneAreaLimit.where(area_id: master_area.id, zone_id: zone.id)
                 .map { |zone_area_limit| zone_area_limit.limit }
  end

end
