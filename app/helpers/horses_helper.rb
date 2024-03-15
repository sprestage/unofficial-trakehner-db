module HorsesHelper

  def link_for_horse(horse)
    return t('horses_index.unknown') if horse.name == "Unknown"
    link_to horse.name, horse
  end

end
