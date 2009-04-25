namespace :rosettasaurus do
  desc 'Populate languages reference data'
  task :populate_languages => :environment do
    puts 'Refreshing languages...'
    Language.delete_all
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (1, "en", "eng", "English")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (2, "de", "ger", "German")');
    Language.connection.execute('INSERT INTO languages (id, tag, description) VALUES (3, "jp", "Japanese")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (4, "es", "spa", "Spanish")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (5, "fr", "fre", "French")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (6, "it", "ita", "Italian")');
    Language.connection.execute('INSERT INTO languages (id, tag, description) VALUES (7, "pt", "Portuguese")');
    Language.connection.execute('INSERT INTO languages (id, tag, description) VALUES (8, "ch", "Chinese")');
    Language.connection.execute('INSERT INTO languages (id, tag, description) VALUES (9, "ru", "Russian")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (10, "pl", "pol", "Polish")');
    Language.connection.execute('INSERT INTO languages (id, tag, lingro_tag, description) VALUES (11, "sv", "swe", "Swedish")');
  end
end