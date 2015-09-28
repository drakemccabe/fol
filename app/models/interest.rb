class Interest < ActiveRecord::Base
    belongs_to :contact

    INTERESTS = ["cultural events", "book clubs",
                 "jazz performances", "workshops"]

    validates :interest, length: { maximum: 200 }, presence: true
    validates :interest, inclusion: { in: INTERESTS }
end
