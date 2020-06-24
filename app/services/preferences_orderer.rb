class PreferencesOrderer
  attr_reader :supports

  def initialize(support, preference)
    @supports = support.family
      .where.not(id: support.id)
      .order(:preference)
      .to_a
        .insert((preference - 1), support)
        .compact
  end

  def order!
    Support.transaction do
      supports.each_with_index do |support, index|
        next if support.preference == (preference = index + 1)

        support.update! preference: preference
      end
    end
  end
end
