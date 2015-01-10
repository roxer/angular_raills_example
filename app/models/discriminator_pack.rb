# encoding: UTF-8
class DiscriminatorPack < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "discriminator_packs"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='discrpack'

  has_many :product_details #, :foreign_key => 'discrpack_id'
  has_many :discriminator_containers #, :foreign_key => 'discrpack_id'
  has_many :discriminators, through: :discriminator_containers

  accepts_nested_attributes_for :discriminator_containers

  attr_accessible :code, :name, :discriminator_containers_attributes, :discriminator


  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa'
  }

end
