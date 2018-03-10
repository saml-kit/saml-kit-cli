class User
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def name_id_for(_format)
    id
  end
end
