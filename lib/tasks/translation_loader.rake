require 'fastercsv'

namespace :rosettasaurus do
  desc "Load translations from a CSV file"
  task :load_translations, :file, :from_language, :to_language, :needs => :environment do |t, args|
    from_language = Language.find_by_tag(args.from_language)
    to_language = Language.find_by_tag(args.to_language)
    FasterCSV.foreach(args.file) do |row|
      translation = Translation.new
      translation.from_sentence = row[0]
      translation.from_language = from_language
      translation.to_sentence = row[1]
      translation.to_language = to_language
      translation.save
      translation.store_edit(User.find_by_login('bandersnatch'), 'Created')
    end
  end
end