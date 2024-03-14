
task :fix_breeders => :environment do
  susan = "Susan Prestage"
  sheila = "Sheila Mowat"

  breeder_susan = Breeder.where( name: "PrestagePrestage" )[0]
  if breeder_susan
    breeder_susan.name = susan
    breeder_susan.save
    puts "Breeder named 'PrestagePrestage' corrected to #{ susan }."
  else
    puts "No breeder named 'PrestagePrestage' to fix."
  end

  dorin = Horse.where( name: "Jädorin" )[0]

  breeder_mowat = Breeder.where( name: "MowatMowat" )[0]
  breeder_sheila = Breeder.where( name: sheila )[0]

  if dorin && breeder_mowat && breeder_sheila
    dorin.breeder = breeder_sheila
    dorin.breeder_id = breeder_sheila.id
    if dorin.save
      puts "Dorin's breeder corrected from 'MowatMowat' to #{sheila}."
      if breeder_mowat.destroy
        puts "Invalid breeder 'MowatMowat' successfully deleted."
      else
        puts "Invalid breeder 'MowatMowat' failed to delete."
      end
    else
      puts "Horse name #{ dorin.name } save-to-database failed"
    end
  end
end


task :load_scraped_json => :environment do
  alphabet = "a".."z"
  alphabet.each do |letter|
    json_filename = 'app/assets/data/json/horses_from_ATA_site/horses_initial_' + letter + '.json'
    puts json_filename

    records = JSON.parse( File.read( json_filename ) )
    records.each do | record |
      Horse.create_from_json( record )
    end
  end
end

task :load_scraped_json_by_letter_input, [:letter] => :environment do |t, args|
  args.with_defaults(:letter => "X")
  puts "Importing json data for horses beginning with the letter '#{args.letter}'."
  json_filename = 'app/assets/data/json/horses_from_ATA_site/horses_initial_' + args.letter.downcase + '.json'
  puts json_filename

  records = JSON.parse( File.read( json_filename ) )
  records.each do | record |
    Horse.create_from_json( record )
  end
end

task :import_stallion_images  => :environment do
  filename = "app/assets/data/json/ata_2013_approved_stallions.json"
  records = JSON.parse( File.read ( filename ) )
  records.each do | r |
    Horse.import_image_from_remote( r, "S" )
  end
end

task :update_stallion_thumbnails => :environment do
  horses = Horse.all()
  horses.each do | horse |
    if horse.image
      horse.image.recreate_versions!
    end
  end
end
