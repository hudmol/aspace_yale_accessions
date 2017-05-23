require 'date'

module FourIdGenerator

  def self.included(base)
    base.extend(ClassMethods)
  end


  def self.inside_import?
    # Requests through the web UI will come in with a high priority, whereas
    # migrations and batch imports will not.
    !RequestContext.get(:is_high_priority)
  end


  @accession_fy_generator = lambda {|json|
    date = Date.parse(json['accession_date'])
    "#{date.month > 6 ? date.year + 1 : date.year}"
  }




  @sequence_generator = lambda {|json|

    type = json["jsonmodel_type"]
    sequence_name = "#{type}_#{json['id_0']}"

    seq = Sequence.get(sequence_name)
    seq = Sequence.get(sequence_name) if seq < 1

    seq.to_s.rjust(4, '0')
  }
  
  @import_generator = lambda {|json|
    "import"
  }


  def self.accession_fy_generator
    @accession_fy_generator
  end


  def self.sequence_generator
    @sequence_generator
  end


  def self.import_generator
    @import_generator
  end


  module ClassMethods

  end
end
