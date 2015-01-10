class StarpackContainer < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "starpack_containers"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  # self.table_name='starpacks'

  belongs_to :starpack #, :foreign_key => 'starpack_id'
  belongs_to :variant #, :foreign_key => 'variant_id'
  accepts_nested_attributes_for :starpack
  accepts_nested_attributes_for :variant

  attr_accessible :starpack_id, :variant_id, :default, :starpack_attributes, :variant_attributes

  HUMANIZED_ATTRIBUTES = {
      :starpack_id => 'Starpack',
      :variant_id => 'variant',
      :default => 'Domyślny'
  }

end
