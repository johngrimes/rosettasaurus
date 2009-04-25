class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages, :force => true, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :tag
      t.string :lingro_tag
      t.string :description
    end
    add_index :languages, :tag
  end

  def self.down
    drop_table :languages
  end
end
