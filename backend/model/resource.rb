require_relative 'mixins/four_id_generator.rb'

Resource.class_eval do
  include AutoGenerator 
  include FourIdGenerator
  
  def create_from_json(json, opts)
    if !FourIdGenerator.inside_import?
      json[:id_0] = nil
    end

    super
  end
end


Resource.properties_to_auto_generate.push ({
  :property => :id_0,
  :generator => FourIdGenerator.sequence_generator,
  :only_if => proc {|json| !FourIdGenerator.inside_import? && ( json[:id_0].nil? || json[:id_0] === 'XXXX' ) }
})

Resource.properties_to_auto_generate.push ({
  :property => :id_1,
  :generator => FourIdGenerator.import_generator,
  :only_if => proc {|json| !FourIdGenerator.inside_import? && json[:id_1].nil?  }
})
