class ProblemSerializer < ActiveModel::Serializer
  attributes :id, :theory, :result, :unit

  def unit
    unit = Unit.find(object.unit_id) if object.unit_id
    {id: unit.id, sign: unit.sign} if unit
  end
end
