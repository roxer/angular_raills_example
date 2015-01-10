# encoding: UTF-8
class AreaContainer < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "area_containers"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='area_incl_excl'

  INCLUDE_EXCLUDE_HASH={'1' => 'zawiera', '2' => 'nie zawiera'}
  INCLUDE_EXCLUDE_LIST=[1, 2]

  belongs_to :area, :foreign_key => 'areas_id'
  belongs_to :master_area, :foreign_key => 'area_id'

  attr_accessible :area_id, :areas_id, :incl_excl

  validates_inclusion_of :incl_excl,
                         :in => INCLUDE_EXCLUDE_LIST,
                         :allow_nil => false,
                         :message => 'tylko "1 - zawiera" albo "2 - nie zawiera"'

  HUMANIZED_ATTRIBUTES = {
      :area_id => 'Obszar nadrzędny',
      :areas_id => 'Obszar (kraj)',
      :incl_excl => 'zawiera/nie zawiera'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
