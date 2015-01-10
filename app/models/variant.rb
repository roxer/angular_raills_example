class Variant < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "variants"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='variant'
  # has_many :starpack_containers, :foreign_key => 'starpack_id'
  has_many :starpack_containers #, :foreign_key => 'variant_id'
  has_many :starpacks, through: :starpack_containers
  has_many :variant_instalments #, :foreign_key => 'variant_id'
  has_many :instalments, through: :variant_instalments
  accepts_nested_attributes_for :variant_instalments, reject_if: :all_blank, allow_destroy: true
  has_many :variant_details, :foreign_key => 'variant_id'
  accepts_nested_attributes_for :variant_details, reject_if: :all_blank, allow_destroy: true

  attr_accessible :code, :name, :default, :status, :sort,
                  :variant_details_attributes, :variant_detail,
                  :variant_instalments_attributes, :variant_instalment

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :default => 'Domyślny',
      :status => 'Status',
      :sort => 'Sortowanie'
  }

end
