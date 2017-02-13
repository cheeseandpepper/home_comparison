class Feature < ApplicationRecord

  belongs_to :house, touch: true
end
