class AnswerSerializer < ActiveModel::Serializer
  attributes :correct, :feedback

  def correct
    object.correct?
  end
end
