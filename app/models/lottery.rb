class Lottery < ActiveRecord::Base
  def to_param
    code
  end
end
