# encoding: UTF-8
class DiscriminatorContainer < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "discriminator_containers"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  # A tak naprawdę, to powinno się stworzyć tabelę discriminator_packs_discriminators
  # i do modeli Discriminator i DiscriminatorPack dodać połączenie has_and_belongs_to_many
  #
  #self.table_name='discrpacks'

  belongs_to :discriminator #, :foreign_key => 'discr_id'
  belongs_to :discriminator_pack #, :foreign_key => 'discrpack_id'
  accepts_nested_attributes_for :discriminator_pack
  accepts_nested_attributes_for :discriminator

  attr_accessible :discriminator_pack_id, :discriminator_id, :discriminator_pack_attributes, :discriminator_attributes

  HUMANIZED_ATTRIBUTES = {
      :discriminator_pack_id => 'Pakiet dyskryminatorów',
      :discriminator_id => 'Dyskryminator'
  }

end
