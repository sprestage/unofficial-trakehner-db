class Horse < ActiveRecord::Base
  default_scope { order( 'name ASC' ) }

  # has_many :offspring, class_name: "Horse", foreign_key: :sire_id,
  #                                           foreign_key: :dam_id

  belongs_to :breeder, class_name: "Breeder", foreign_key: :breeder_id, optional: true
  belongs_to :sire, class_name: "Horse", foreign_key: :sire_id
  belongs_to :dam, class_name: "Horse", foreign_key: :dam_id

  validates :name, presence: true
  validates :name, uniqueness: true

  # mount_uploader :image, ImageUploader

  def self.search( search, has_image )
    result = nil
    if search
      # ILIKE == case-insensitive LIKE for PostgreSQL
      result = Horse.all.where( [ 'name ILIKE ?', "%#{ search }%" ] )
      if has_image == 'on'
        result = result.where( [ 'image != ?', "%""%" ] )
      end
    else
      result = Horse.all
    end
    result
  end

  alias_method :default_sire, :sire
  def sire
    return self.default_sire || Horse.new( name: I18n.t('horses_index.unknown') )
  end

  alias_method :default_dam, :dam
  def dam
    return self.default_dam || Horse.new( name: I18n.t('horses_index.unknown') )
  end

  def get_progeny
    Horse.where( "sire_id = ? OR dam_id = ?", "#{ id }", "#{ id }" )
  end

  def self.create_from_json( record )

    if record[ "name" ].empty? || record[ "name" ] == nil
      puts "Empty name in horse record, dumping data"
      puts record
      return
    end

    horse = Horse.fetch( record[ "name" ] )

    horse.registration_number = record[ "registration_number" ]
    horse.gender = record["sex"] == "V" ? "S" : record["sex"]
    horse.color = record[ "color" ]
    horse.birth_year = record[ "birth_year" ]

    horse.sire = get_parent( record[ "sire" ], "S" )
    horse.dam = get_parent( record[ "dam"], "M" )

    ###
    # The schema shows .performance_records_available to be a boolean.  However, it isn't
    #   being treated like a boolean.  Forcing boolean behavior for now, but this should
    #   be looked into.  -sprestage 8/21/15
    ###
    # horse.performance_records_available = record["performance_records_available"]
    ###
    if record[ "performance_records_available" ] == ""
      horse.performance_records_available = false
    else
      horse.performance_records_available = true
    end

    if horse.save
      # Do nothing if the save is successful.
    else
      puts "Horse name #{ horse.name } save-to-database failed"
    end

  end

  def self.get_parent( parent_name, gender )
    parent = nil
    unless parent_name.empty? || parent_name == nil || parent_name == "---"
      parent = Horse.find_by name: parent_name
      unless parent
        parent = Horse.new(name: parent_name)
        parent.gender = gender
        parent.save!
      end
    end
    return parent
  end

  def self.import_image_from_remote( record, gender )
    horse = Horse.find_by name: record[ "name" ]
    unless horse
      horse = Horse.new
      horse.name = record[ "name" ]
    end
    horse.gender = gender
    horse.image = record[ "image" ]
    horse.thumbnail = record[ "picture" ]

    if horse.save
      # Do nothing if the save is successful.
    else
      puts "Horse name #{ horse.name } save-to-database failed"
    end
  end

  def self.fetch( name )

    unless name.empty? || name == nil || name == "---"
      horse = Horse.find_by name: name
      unless horse
        horse = Horse.new
        horse.name = name
        horse.save!
      end
    end
    return horse
  end

end
