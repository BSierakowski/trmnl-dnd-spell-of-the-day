require 'net/http'
require 'json'
require 'uri'

BASE_URL = 'https://www.dnd5eapi.co/api/2014/spells/'

spells = [  "acid-arrow",
            "acid-splash",
            "aid",
            "alarm",
            "alter-self",
            "animal-friendship",
            "animal-messenger",
            "animal-shapes",
            "animate-dead",
            "animate-objects",
            "antilife-shell",
            "antimagic-field",
            "antipathy-sympathy",
            "arcane-eye",
            "arcane-hand",
            "arcane-lock",
            "arcane-sword",
            "arcanists-magic-aura",
            "astral-projection",
            "augury",
            "awaken",
            "bane",
            "banishment",
            "barkskin",
            "beacon-of-hope",
            "bestow-curse",
            "black-tentacles",
            "blade-barrier",
            "bless",
            "blight",
            "blindness-deafness",
            "blink",
            "blur",
            "branding-smite",
            "burning-hands",
            "call-lightning",
            "calm-emotions",
            "chain-lightning",
            "charm-person",
            "chill-touch",
            "circle-of-death",
            "clairvoyance",
            "clone",
            "cloudkill",
            "color-spray",
            "command",
            "commune",
            "commune-with-nature",
            "comprehend-languages",
            "compulsion",
            "cone-of-cold",
            "confusion",
            "conjure-animals",
            "conjure-celestial",
            "conjure-elemental",
            "conjure-fey",
            "conjure-minor-elementals",
            "conjure-woodland-beings",
            "contact-other-plane",
            "contagion",
            "contingency",
            "continual-flame",
            "control-water",
            "control-weather",
            "counterspell",
            "create-food-and-water",
            "create-or-destroy-water",
            "create-undead",
            "creation",
            "cure-wounds",
            "dancing-lights",
            "darkness",
            "darkvision",
            "daylight",
            "death-ward",
            "delayed-blast-fireball",
            "demiplane",
            "detect-evil-and-good",
            "detect-magic",
            "detect-poison-and-disease",
            "detect-thoughts",
            "dimension-door",
            "disguise-self",
            "disintegrate",
            "dispel-evil-and-good",
            "dispel-magic",
            "divination",
            "divine-favor",
            "divine-word",
            "dominate-beast",
            "dominate-monster",
            "dominate-person",
            "dream",
            "druidcraft",
            "earthquake",
            "eldritch-blast",
            "enhance-ability",
            "enlarge-reduce",
            "entangle",
            "enthrall",
            "etherealness",
            "expeditious-retreat",
            "eyebite",
            "fabricate",
            "faerie-fire",
            "faithful-hound",
            "false-life",
            "fear",
            "feather-fall",
            "feeblemind",
            "find-familiar",
            "find-steed",
            "find-the-path",
            "find-traps",
            "finger-of-death",
            "fire-bolt",
            "fire-shield",
            "fire-storm",
            "fireball",
            "flame-blade",
            "flame-strike",
            "flaming-sphere",
            "flesh-to-stone",
            "floating-disk",
            "fly",
            "fog-cloud",
            "forbiddance",
            "forcecage",
            "foresight",
            "freedom-of-movement",
            "freezing-sphere",
            "gaseous-form",
            "gate",
            "geas",
            "gentle-repose",
            "giant-insect",
            "glibness",
            "globe-of-invulnerability",
            "glyph-of-warding",
            "goodberry",
            "grease",
            "greater-invisibility",
            "greater-restoration",
            "guardian-of-faith",
            "guards-and-wards",
            "guidance",
            "guiding-bolt",
            "gust-of-wind",
            "hallow",
            "hallucinatory-terrain",
            "harm",
            "haste",
            "heal",
            "healing-word",
            "heat-metal",
            "hellish-rebuke",
            "heroes-feast",
            "heroism",
            "hideous-laughter",
            "hold-monster",
            "hold-person",
            "holy-aura",
            "hunters-mark",
            "hypnotic-pattern",
            "ice-storm",
            "identify",
            "illusory-script",
            "imprisonment",
            "incendiary-cloud",
            "inflict-wounds",
            "insect-plague",
            "instant-summons",
            "invisibility",
            "irresistible-dance",
            "jump",
            "knock",
            "legend-lore",
            "lesser-restoration",
            "levitate",
            "light",
            "lightning-bolt",
            "locate-animals-or-plants",
            "locate-creature",
            "locate-object",
            "longstrider",
            "mage-armor",
            "mage-hand",
            "magic-circle",
            "magic-jar",
            "magic-missile",
            "magic-mouth",
            "magic-weapon",
            "magnificent-mansion",
            "major-image",
            "mass-cure-wounds",
            "mass-heal",
            "mass-healing-word",
            "mass-suggestion",
            "maze",
            "meld-into-stone",
            "mending",
            "message",
            "meteor-swarm",
            "mind-blank",
            "minor-illusion",
            "mirage-arcane",
            "mirror-image",
            "mislead",
            "misty-step",
            "modify-memory",
            "moonbeam",
            "move-earth",
            "nondetection",
            "pass-without-trace",
            "passwall",
            "phantasmal-killer",
            "phantom-steed",
            "planar-ally",
            "planar-binding",
            "plane-shift",
            "plant-growth",
            "poison-spray",
            "polymorph",
            "power-word-kill",
            "power-word-stun",
            "prayer-of-healing",
            "prestidigitation",
            "prismatic-spray",
            "prismatic-wall",
            "private-sanctum",
            "produce-flame",
            "programmed-illusion",
            "project-image",
            "protection-from-energy",
            "protection-from-evil-and-good",
            "protection-from-poison",
            "purify-food-and-drink",
            "raise-dead",
            "ray-of-enfeeblement",
            "ray-of-frost",
            "regenerate",
            "reincarnate",
            "remove-curse",
            "resilient-sphere",
            "resistance",
            "resurrection",
            "reverse-gravity",
            "revivify",
            "rope-trick",
            "sacred-flame",
            "sanctuary",
            "scorching-ray",
            "scrying",
            "secret-chest",
            "see-invisibility",
            "seeming",
            "sending",
            "sequester",
            "shapechange",
            "shatter",
            "shield",
            "shield-of-faith",
            "shillelagh",
            "shocking-grasp",
            "silence",
            "silent-image",
            "simulacrum",
            "sleep",
            "sleet-storm",
            "slow",
            "spare-the-dying",
            "speak-with-animals",
            "speak-with-dead",
            "speak-with-plants",
            "spider-climb",
            "spike-growth",
            "spirit-guardians",
            "spiritual-weapon",
            "stinking-cloud",
            "stone-shape",
            "stoneskin",
            "storm-of-vengeance",
            "suggestion",
            "sunbeam",
            "sunburst",
            "symbol",
            "telekinesis",
            "telepathic-bond",
            "teleport",
            "teleportation-circle",
            "thaumaturgy",
            "thunderwave",
            "time-stop",
            "tiny-hut",
            "tongues",
            "transport-via-plants",
            "tree-stride",
            "true-polymorph",
            "true-resurrection",
            "true-seeing",
            "true-strike",
            "unseen-servant"
]

class DndSpell
  attr_reader :index, :name, :description, :higher_level, :range, :components,
              :material, :ritual, :duration, :concentration, :casting_time,
              :level, :dc, :area_of_effect, :school, :classes

  def initialize(spell_data)
    @index = spell_data["index"]
    @name = spell_data["name"]
    @description = spell_data["desc"]
    @higher_level = spell_data["higher_level"]
    @range = spell_data["range"]
    @components = spell_data["components"]
    @material = spell_data["material"]
    @ritual = spell_data["ritual"]
    @duration = spell_data["duration"]
    @concentration = spell_data["concentration"]
    @casting_time = spell_data["casting_time"]
    @level = spell_data["level"]
    @dc = parse_dc(spell_data["dc"])
    @area_of_effect = parse_area_of_effect(spell_data["area_of_effect"])
    @school = parse_school(spell_data["school"])
    @classes = parse_classes(spell_data["classes"])
  end

  def parse_dc(dc_data)
    return nil unless dc_data
    {
      type: dc_data["dc_type"]["name"],
      success: dc_data["dc_success"]
    }
  end

  def parse_area_of_effect(aoe_data)
    return nil unless aoe_data
    {
      type: aoe_data["type"],
      size: aoe_data["size"]
    }
  end

  def parse_school(school_data)
    return nil unless school_data
    {
      name: school_data["name"],
      index: school_data["index"]
    }
  end

  def parse_classes(classes_data)
    return [] unless classes_data
    classes_data.map { |cls| cls["name"] }
  end

  def to_s
    <<~SPELL_INFO
      Name: #{@name} (Level #{@level})
      School: #{@school&.dig(:name) || 'Unknown'}
      Casting Time: #{@casting_time}
      Range: #{@range}
      Components: #{@components.join(', ')}#{@material ? " (#{@material})" : ''}
      Duration: #{@duration}#{@concentration ? ' (Concentration)' : ''}
      Classes: #{@classes.join(', ')}

      Description:
      #{@description.join("\n\n")}

      #{@higher_level ? "At Higher Levels:\n#{@higher_level.join("\n")}" : ''}
    SPELL_INFO
  end
end

def parse_spell_response(json_response)
  spell = DndSpell.new(json_response)
  puts spell.to_s
end

def fetch_spell_data(spell_name)
  # Create the full URL
  url = URI.parse(BASE_URL + spell_name)

  puts "Fetching data for spell: #{spell_name}"
  puts "URL: #{url}"

  # Create HTTP object
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true if url.scheme == 'https'

  # Create the request
  request = Net::HTTP::Get.new(url.request_uri)

  begin
    # Send the request and get the response
    response = http.request(request)

    # Check if the request was successful
    if response.code.to_i == 200
      # Parse and return the JSON response
      JSON.parse(response.body)
    else
      puts "Error: #{response.code} - #{response.message} for spell: #{spell_name}"
      nil
    end
  rescue StandardError => e
    puts "Error fetching data for #{spell_name}: #{e.message}"
    nil
  end
end

spell_data = fetch_spell_data(spells.sample)
parse_spell_response(spell_data)
