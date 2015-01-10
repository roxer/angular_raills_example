# encoding: UTF-8
class InsuranceSubcategory < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "subcategories"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='cats'

  belongs_to :insurance_category #, :foreign_key => 'cat_id'
  has_many :product_details, dependent: :destroy

  attr_accessible :insurance_category_id, :code, :external_code, :visibility, :name, :tip, :tip_url, :sort, :icon_code, :other

  HUMANIZED_ATTRIBUTES = {
      :cat_id => 'Kategoria',
      :code => 'Kod',
      :external_code => 'Kod zewnętrzny',
      :visibility => 'Widoczność',
      :name => 'Nazwa',
      :tip => 'Tip',
      :tip_url => 'Tip URL',
      :sort => 'Sortowanie',
      :icon_code => 'Ikona',
      :other => 'Inne'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
