class Version < ActiveRecord::Base
  # Aby uczynić tę tabelę bliżej RoR należy:
  # nazwać ją "versions"
  # dodać pola created_at :datetime, updated_at :datetime
  #
  #self.table_name='version'
  has_many :starpacks

  attr_accessible :code, :descr, :default

  HUMANIZED_ATTRIBUTES = {
      :code => 'Kod',
      :descr => 'Opis',
      :default => 'Domyślny'
  }

end
