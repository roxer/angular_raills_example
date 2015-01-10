# encoding: UTF-8
class Limit < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # dodać pola created_at :datetime, updated_at :datetime
  #

  attr_accessible :code, :name, :qty, :unit, :type

  self.inheritance_column = nil # aby nie mieszało się z modelem Tupe zdefiniowanym wcześniej

  has_many :zone_area_limits #, :foreign_key => 'limits_id'
  has_many :master_areas, :through => :zone_area_limits

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :qty => 'Ilość',
      :unit => 'Jednostka',
      :type => 'Typ'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
