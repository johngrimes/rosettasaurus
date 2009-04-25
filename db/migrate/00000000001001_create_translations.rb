class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations, :force => true, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :from_sentence, :length => 1000
      t.integer :from_language_id
      t.string :to_sentence, :length => 1000
      t.integer :to_language_id

      t.timestamps
    end
  end

  def self.down
    drop_table :translations
  end
end
