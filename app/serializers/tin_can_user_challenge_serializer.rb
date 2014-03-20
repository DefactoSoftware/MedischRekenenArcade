class TinCanUserChallengeSerializer < ActiveModel::Serializer
  attributes :actor, :verb, :object
  attribute :_object, key: :object

  def actor
    {
      mbox: "mailto:#{object.user.email}",
      name: object.user.name,
      objectType: "Agent"
    }
  end

  def verb
    {
      id: "http://adlnet.gov/expapi/verbs/completed/",
      display: {
        en_US: "completed",
        nl_NL: "gehaald"
      }
    }
  end

  def _object
    {
      id: object.id,
      objectType: "Challenge",
      definition: {
        name: {
            en_US: I18n.t("challenges.#{object.challenge.name.underscore}.title", locale: :en),
            nl_NL: I18n.t("challenges.#{object.challenge.name.underscore}.title", locale: :nl)
        },
        description: {
            en_US: I18n.t("challenges.#{object.challenge.name.underscore}.info", locale: :en),
            nl_NL: I18n.t("challenges.#{object.challenge.name.underscore}.info", locale: :nl)
        }
      }
    }
  end
end
