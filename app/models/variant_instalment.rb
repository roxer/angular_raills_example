class VariantInstalment < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "variant_instalments"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='variant_instalment'
  belongs_to :variant #, :foreign_key => 'variant_id'
  belongs_to :instalment #, :foreign_key => 'instalment_id'
  accepts_nested_attributes_for :variant
  accepts_nested_attributes_for :instalment

  attr_accessible :variant_id, :instalment_id, :variant_attributes, :instalment_attributes

  HUMANIZED_ATTRIBUTES = {
      :variant_id => 'Wariant',
      :instalment_id => 'instalment'
  }

end
