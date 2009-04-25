class CreateEdits < ActiveRecord::Migration
  def self.up
    create_table :edits, :force => true, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :translation_id
      t.integer :user_id
      t.string :from_sentence, :length => 1000
      t.integer :from_language_id
      t.string :to_sentence, :length => 1000
      t.integer :to_language_id
      t.string  :comment, :length => 1000
      t.datetime :edited_at
    end
  end

  def self.down
    drop_table :edits
  end
end
