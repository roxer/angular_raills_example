# encoding: UTF-8
class RiskProduct < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "risk_products"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='pkb_risk'

  belongs_to :product #, :foreign_key => 'pkb_id'
  belongs_to :risk #, :foreign_key => 'risk_id'
  accepts_nested_attributes_for :product
  accepts_nested_attributes_for :risk

  attr_accessible :product_id, :risk_id, :product_attributes, :risk_attributes

  HUMANIZED_ATTRIBUTES = {
      :product_id => 'Produkt',
      :risk_id => 'Ryzyko'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
