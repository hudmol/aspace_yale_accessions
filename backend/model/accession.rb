require_relative 'mixins/four_id_generator.rb'

Accession.class_eval do
  include FourIdGenerator
    
  def create_from_json(json, opts)
    if !FourIdGenerator.inside_import?
      json[:id_1] = nil
    end

    super
  end

end

Accession.properties_to_auto_generate.push ({
  :property => :id_0,
  :generator => FourIdGenerator.accession_fy_generator,
  :only_if => proc { true }
})

Accession.properties_to_auto_generate.push ({
  :property => :id_1,
  :generator => FourIdGenerator.sequence_generator,
  :only_if => proc {|json| !FourIdGenerator.inside_import? && ( json[:id_1].nil? || json[:id_1] === 'XXXX' ) }
})

Accession.properties_to_auto_generate.push ({
  :property => :id_2,
  :generator => FourIdGenerator.import_generator,
  :only_if => proc {|json| !FourIdGenerator.inside_import? && json[:id_2].nil?  }
})
