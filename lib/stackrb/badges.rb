module StackRb
  class Badges
    include StackRb

    property :gold
    property :silver
    property :bronze
      
    def initialize(badge_json)
      fill_properties(badge_json)
    end
  end
end
