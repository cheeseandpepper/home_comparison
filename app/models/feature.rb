class Feature < ApplicationRecord

  belongs_to :house, touch: true

  default_scope { order('lower (name)') }
end
