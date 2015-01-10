# encoding: UTF-8
class InsuranceCategory < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "categories"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='cat'

  belongs_to :type
  has_many :insurance_subcategories #, :foreign_key => 'cat_id', dependent: :destroy

  attr_accessible :code, :name, :type_id, :tip, :tip_ulr, :icon_code, :all_offers_header, :sort, :filter

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :type_id => 'Typ',
      :tip => 'Tip',
      :tip_ulr => 'Tip URL',
      :icon_code => 'Ikona',
      :all_offers_header => 'all_offers_header',
      :sort => 'Sortowanie',
      :filter => 'Filtr'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
