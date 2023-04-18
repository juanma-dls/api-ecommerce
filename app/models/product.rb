class Product < ApplicationRecord
  def soft_delete
    update(deleted: !deleted)
  end

  def active?
    !deleted
  end
end
