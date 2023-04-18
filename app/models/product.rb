class Product < ApplicationRecord
  def soft_delete
    update(deleted: true)
  end

  def active?
    !deleted
  end
end
