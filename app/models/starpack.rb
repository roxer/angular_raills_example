class Starpack < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "starpacks"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='starpack'
  belongs_to :channel
  belongs_to :type
  belongs_to :version
  has_many :starpack_containers #, :foreign_key => 'starpack_id'
  has_many :variants, through: :starpack_containers
  accepts_nested_attributes_for :starpack_containers, reject_if: :all_blank, allow_destroy: true

  attr_accessible :code, :name, :rate_from, :default, :channel_id, :type_id, :version_id,
                  :status, :main_products,
                  :starpack_containers_attributes, :variant

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :rate_from => 'rate_from',
      :default => 'default',
      :channel_id => 'Kanał',
      :type_id => 'Typ',
      :version_id => 'Wersja',
      :status => 'Status',
      :main_products => 'main_products'
  }

end
