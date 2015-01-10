class Instalment < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "instalments"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='instalment'

  attr_accessible :code, :name, :ratios

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :name => 'Nazwa',
      :ratios => 'ratios'
  }

end
