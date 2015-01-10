class VariantDetail < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "variant_details"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  # self.table_name='variants'
  belongs_to :variant #, :foreign_key => 'variant_id'
  belongs_to :product_detail #, :foreign_key => 'pkb_cats_discr_id'

  attr_accessible :variant_id, :product_detail_id, :default, :required, :prodtype,
                  :full_code_queue, :code, :parent_code, :value

  HUMANIZED_ATTRIBUTES = {
      :variant_id => 'variant_id',
      :product_detail_id => 'product_detail_id',
      :default => 'default',
      :required => 'required',
      :prodtype => 'prodtype',
      :full_code_queue => 'full_code_queue',
      :code => 'code',
      :parent_code => 'parent_code',
      :value => 'value'
  }

end
