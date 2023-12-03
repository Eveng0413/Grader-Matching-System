class RealApplication < ApplicationRecord
    validates :status, inclusion: { in: %w[pending approved denied] }
    validates :time_intrested, inclusion: { in: %w[morning afternoon evening] }
end
