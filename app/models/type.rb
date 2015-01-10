# encoding: UTF-8
class Type < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "types"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='type'
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :starpacks

  attr_accessible :code, :name

  validates_uniqueness_of :code
  validates_presence_of :code, :name


  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
