# encoding: UTF-8
class Insurer < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "insurers"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='insurer'
  has_many :channels

  attr_accessible :code, :name, :status

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :status => 'Status'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
