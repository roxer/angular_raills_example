# encoding: UTF-8
class Discriminator < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "discriminators"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='discr'

  has_many :discriminator_containers #, :foreign_key => 'discr_id'
  has_many :discriminator_packs, through: :discriminator_containers

  accepts_nested_attributes_for :discriminator_containers

  attr_accessible :vehicle_min_age, :vehicle_max_age, :driver_min_age, :driver_max_age, :claims_max_qty, :claims_period,
                  :vehicle_type_incl, :vehicle_type_excl, :vehicle_usage_incl, :vehicle_usage_excl, :theft_prot_mech_min_qty,
                  :theft_prot_electr_min_qty, :worth_min, :theft_prot_min_qty, :notes,
                  :discriminator_containers_attributes


  HUMANIZED_ATTRIBUTES = {
      :vehicle_min_age => 'vehicle_min_age',
      :vehicle_max_age => 'vehicle_max_age',
      :driver_min_age => 'driver_min_age',
      :driver_max_age => 'driver_max_age',
      :claims_max_qty => 'claims_max_qty',
      :claims_period => 'claims_period',
      :vehicle_type_incl => 'vehicle_type_incl',
      :vehicle_type_excl => 'vehicle_type_excl',
      :vehicle_usage_incl => 'vehicle_usage_incl',
      :vehicle_usage_excl => 'vehicle_usage_excl',
      :theft_prot_mech_min_qty => 'theft_prot_mech_min_qty',
      :theft_prot_electr_min_qty => 'theft_prot_electr_min_qty',
      :worth_min => 'worth_min',
      :theft_prot_min_qty => 'theft_prot_min_qty',
      :notes => 'Opis'
  }
end
