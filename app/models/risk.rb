# encoding: UTF-8
class Risk < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "risks"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='risk'

  has_many :risk_products # RM , :foreign_key => 'risk_id'
  has_many :products, through: :risk_products

  # RM attr_accessible :code, :name, :incl_excl, :risk_products_attributes

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :incl_excl => 'zawiera/nie zawiera'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
