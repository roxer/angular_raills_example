# encoding: UTF-8
class ProductDetail < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "product_details"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  self.table_name='pkb_cats_discr'

  belongs_to :zone
  belongs_to :product #, :foreign_key => 'pkb_id'
  belongs_to :insurance_subcategory #, :foreign_key => 'cats_id'
  belongs_to :discriminator_pack #, :foreign_key => 'discrpack_id'

  attr_accessible :product_id, :insurance_subcategory_id, :amount, :percent, :onoff,
                  :descr, :note, :discriminator_pack_id, :zone_id, :zone_name_embedded

  #taka kulawa łata z tym '-1', ale Michał chciał znaczącego null i stąd problem
  ON_OFF_HASH = {'-1' => '[ ] puste', '0' => '[x] brak', '1' => '[v] jest'}

  HUMANIZED_ATTRIBUTES = {
      :pkb_id => 'Produkt źródłowy',
      :cats_id => 'Podkategoria',
      :amount => 'Ilość',
      :percent => 'Ilość w %',
      :onoff => 'Jest/nie ma',
      :descr => 'Opis',
      :note => 'Opis rozwinięty',
      :discrpack_id => 'Dyskryminator',
      :zone_id => 'Strefa',
      :zone_name_embedded => 'Nazwa zakresu terytorialnego wbudowana'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

end
