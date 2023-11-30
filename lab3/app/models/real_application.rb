class RealApplication < ApplicationRecord
    validates :status, inclusion: { in: %w[pending approved denied] }
end
