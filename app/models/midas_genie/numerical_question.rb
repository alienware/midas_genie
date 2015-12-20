# == Schema Information
#
# Table name: midas_genie_questions
#
#  id          :integer          not null, primary key
#  title       :text             not null
#  description :text
#  remark      :text
#  type        :string           not null
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module MidasGenie
  class NumericalQuestion < MidasGenie::Question
  end
end
