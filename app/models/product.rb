# encoding: UTF-8
class Product < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "products"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='pkb'
  belongs_to :channel
  belongs_to :type
  has_many :product_details #, :foreign_key => 'pkb_id'
  has_many :risk_products #, :foreign_key => 'pkb_id'
  has_many :risks, through: :risk_products
  accepts_nested_attributes_for :risk_products, reject_if: :all_blank, allow_destroy: true

  belongs_to :parent,
             :foreign_key => 'parent_id',
             :class_name => 'Product'

  has_many :children,
           -> {order 'id ASC'},
           :foreign_key => 'parent_id',
           :class_name => 'Product',
           :dependent => :destroy

  scope :all_top_level, ->() { where(parent_id: '0') }
  scope :all_final, ->() { where(final: '1') }

  attr_accessible :code, :name, :channel_id, :type_id, :status, :parent_id, :final,
                  :price, :attr, :risk_products_attributes, :risk

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :channel_id => 'Kanał komunikacji',
      :type_id => 'Typ',
      :status => 'Status',
      :parent_id => 'Rodzic',
      :final => 'Produkt końcowy',
      :price => 'Cena',
      :attr => 'Atrybut przeniesienia nazwy'
  }

  # def self.human_attribute_name(attr)
  #   HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  # end

  def generate_risks_from_params(risk_products_params)
    urip = UpdateRisksInProduct.new(risk_products_params, self)
    urip.generate_models
  end

  def ancestors_tree
    ancestors_list=[]
    ancestor=self
    begin
      ancestor=ancestor.parent
      ancestors_list.append ancestor unless ancestor.blank?
    end until ancestor.blank?
    ancestors_list.reverse
  end

  def code_name
    "[#{self.code}] #{self.name}"
  end

  def has_channel?
    !self.channel_id.blank?
  end

  def has_parent?
    !self.parent_id.blank?
  end

end
