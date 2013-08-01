require 'json'

class Facts

  def get_facts
    fact_file = "data/facts.json"
    fact_json = File.read(fact_file)
    the_facts = JSON.parse(fact_json)
    the_facts["facts"]
  end
end